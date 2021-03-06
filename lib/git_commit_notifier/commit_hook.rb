require 'yaml'
require 'cgi'
require 'net/smtp'
require 'digest/sha1'

module GitCommitNotifier
  class CommitHook

    class << self
      attr_reader :config

      def show_error(message)
        $stderr.puts "************** GIT NOTIFIER PROBLEM *******************"
        $stderr.puts "\n"
        $stderr.puts message
        $stderr.puts "\n"
        $stderr.puts "************** GIT NOTIFIER PROBLEM *******************"
      end

      def info(message)
        $stdout.puts message
        $stdout.flush
      end

      def logger
        @logger ||= Logger.new(config)
      end

      def include_branches
        include_branches = config["include_branches"]
        unless include_branches.nil?
          if include_branches.kind_of?(String) && include_branches =~ /\,/
            include_branches = include_branches.split(/\s*\,\s*/)
          end
          include_branches = Array(include_branches)
        end
        include_branches
      end

      def run(config_name, rev1, rev2, ref_name)
        @config = File.exists?(config_name) ? YAML::load_file(config_name) : {}

        project_path = Dir.getwd
        recipient = config["mailinglist"] || Git.mailing_list_address

        if recipient.nil? || recipient.length == 0
          CommitHook.show_error(
            "Please add a recipient for the emails. Eg : \n" +
            "      git config hooks.mailinglist  developer@example.com"
          )
          return
        end

        logger.debug('----')
        logger.debug("pwd: #{Dir.pwd}")
        logger.debug("ref_name: #{ref_name}")
        logger.debug("rev1: #{rev1}")
        logger.debug("rev2: #{rev2}")
        logger.debug("included branches: #{include_branches.join(', ')}") unless include_branches.nil?

        prefix = config["emailprefix"] || Git.repo_name
        branch_name = ref_name.split("/").last

        logger.debug("prefix: #{prefix}")
        logger.debug("branch: #{branch_name}")

        unless include_branches.nil? || include_branches.include?(branch_name)
          info("Supressing mail for branch #{branch_name}...")
          return
        end

        branch_name = "/#{branch_name}"
        branch_name = "" if !config["show_master_branch_name"] && branch_name.eql?('/master')
        
        info("Sending mail...")

        diff2html = DiffToHtml.new(Dir.pwd, config)
        diff2html.diff_between_revisions(rev1, rev2, prefix, ref_name)

        diffresult = diff2html.result

        if config["ignore_merge"]
          diffresult = diffresult.reject do |result|
            !result[:commit_info][:merge].nil?
          end
        end

        if config["group_email_by_push"]
          text, html = [], []
          diffresult.each_with_index do |result, i|
            text << result[:text_content]
            html << result[:html_content]
          end
          result = diffresult.first
          return if result.nil? || !result[:commit_info]

          emailer = Emailer.new(config,
            :project_path => project_path,
            :recipient => recipient,
            :from_address => config["from"] || result[:commit_info][:email],
            :from_alias => result[:commit_info][:author],
            :subject => "[#{prefix}#{branch_name}] #{diffresult.size > 1 ? "#{diffresult.size} commits: " : ''}#{result[:commit_info][:message]}",
            :text_message => text.join("------------------------------------------\n\n"),
            :html_message => html.join("<hr /><br />"),
            :old_rev => rev1,
            :new_rev => rev2,
            :ref_name => ref_name
          )
          emailer.send
        else
          diffresult.reverse.each_with_index do |result, i|
            next unless result[:commit_info]
            nr = number(diffresult.size, i)

            emailer = Emailer.new(config,
              :project_path => project_path,
              :recipient => recipient,
              :from_address => config["from"] || result[:commit_info][:email],
              :from_alias => result[:commit_info][:author],
              :subject => "[#{prefix}#{branch_name}]#{nr} #{result[:commit_info][:message]}",
              :text_message => result[:text_content],
              :html_message => result[:html_content],
              :old_rev => rev1,
              :new_rev => rev2,
              :ref_name => ref_name
            )
            emailer.send
          end
        end
      end

      def number(total_entries, i)
        return '' if total_entries <= 1
        digits = total_entries < 10 ? 1 : 3
        '[' + sprintf("%0#{digits}d", i + 1) + ']'
      end
    end
  end
end
