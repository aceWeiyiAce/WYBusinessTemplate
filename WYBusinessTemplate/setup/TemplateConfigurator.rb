require 'colored2'
require 'FileUtils'

module Pod
  class TemplateConfigurator
    
        attr_reader :prefix, :created_by, :organization

        def initialize(pod_name = "CPDBusinessModule")
          @pod_name = pod_name
          @pod_dir = File.dirname(File.dirname(File.expand_path(__FILE__)))
          @prefix = "CPD"
          @func_prefix = "funccpd"
          @created_by = "CREATEDBYAUTHOR"
          @organization = "CUSTOMORGANIZATIONNAME"
          @homepage_url = "HOMEPAGE_URL"
          @repo_url = "REPO_URL"
        end
    
        def run

          get_infos

          puts "\n" + "begin TemplateConfigurator".magenta + " on your new library."
          puts ""

          Dir.chdir(@pod_dir)
          @string_replacements = {
            "PROJECT" => @pod_name,
            "CPD" => @prefix,
            "Funccpd" => @func_prefix[0].upcase + @func_prefix[1, @func_prefix.length],
            "funccpd" => @func_prefix,
            "CREATEDBYAUTHOR" => @created_by,
            "CUSTOMORGANIZATIONNAME" => @organization
          }

          clean_template_files
          rename_template_files
          podspec_replace
          rename_file

          puts "\n" + "End TemplateConfigurator".magenta + " on your new library."
          puts ""

          ensure_carthage_compatibility
          reinitialize_git_repo
          run_pod_install
          farewell_message

        end

        def get_infos
          loop do
            @homepage_url = ask("Homepage:")
            @repo_url = ask("Repo:")
            @organization = ask("Organization:")
            @created_by = (ENV['GIT_COMMITTER_NAME'] || `git config user.name`).strip
            @prefix = ask("Prefix:")
            @func_prefix = ask("Function prefix:")

            puts ""
            puts "Homepage: " + @homepage_url.magenta
            puts "Repo: " + @repo_url.magenta
            puts "Organization: " + @organization.magenta
            puts "Created by: " + @created_by.magenta
            puts "Prefix: " + @prefix.magenta
            puts "Function prefix: " + @func_prefix.magenta

            sure = ""
            loop do
              sure = ask("Begin? [YES / NO]").upcase
              if sure == "YES" || sure == "Y" || sure == "NO" || sure == "N"
                break
              end
            end

            if sure == "YES" || sure == "Y"
              break
            end
          end
        end
  
        def rename_file
          puts "\nRunning " + "rename files".magenta + " on your new library."
          puts ""

          dirs = Dir.glob("#{@pod_dir}/**/**")
          dirs.reverse_each do |name|
            basename = File.basename(name)
            dirname = File.dirname(name)
            if (dirname.include? "Pods") || (dirname.include? "VendoredFrameworks") || (dirname.include? "setup")
              next
            end
            if File.file?(name) && !(dirname.include? ".xcassets")
              text = File.read(name)
              for find, replace in @string_replacements do
                text = text.gsub(find, replace)
              end
              text = text.gsub("YEAR", year)
              text = text.gsub("MONTH", month)
              text = text.gsub("DAY", day)
              File.open(name, "w") { |file| file.puts text }
            end
            new_basename = basename.gsub("PROJECT", @pod_name)
            new_basename = new_basename.gsub("CPD", @prefix)
            new_name = File.join(dirname, new_basename)
            File.rename(name, new_name)
            puts new_name
          end
  
        end

        def podspec_replace
          podspec = File.join(@pod_dir, "PROJECT.podspec")
          text = File.read(podspec)
          text = text.gsub("HOMEPAGE_URL", @homepage_url)
          text = text.gsub("REPO_URL", @repo_url)
          File.open(podspec, "w") { |file| file.puts text }
        end
  
        def run_pod_install
          puts "\nRunning " + "pod install".magenta + " on your new library."
          puts ""
          
          Dir.chdir(File.join(@pod_dir, "Example")) do
            system "pod install"
          end
    
          `git add #{@pod_dir}/Example/#{@pod_name}.xcodeproj/project.pbxproj`
          `git add #{@pod_dir}/Example/Podfile.lock`
          `git add #{@pod_dir}/Example/#{@pod_name}.xcworkspace/contents.xcworkspacedata`
          `git commit -m "Initial commit"`
        end
  
        def ensure_carthage_compatibility
          FileUtils.ln_s(File.join(@pod_dir, 'Example/Pods/Pods.xcodeproj'), File.join(@pod_dir, '_Pods.xcodeproj'))
        end
  
        def clean_template_files
          puts "\n" + "Clean template files".magenta + " on your new library."
          puts ""

          ["setup", "configure", "README.md", "LICENSE", "Example/PROJECT.xcodeproj/xcshareddata/IDETemplateMacros.plist"].each do |asset|
            file_path = File.join(@pod_dir, asset)
            `rm -rf #{file_path}`
          end
        end

        def rename_template_files
          FileUtils.mv File.join(@pod_dir, "POD_README.md"), File.join(@pod_dir, "README.md")
          FileUtils.mv File.join(@pod_dir, "POD_LICENSE"), File.join(@pod_dir, "LICENSE")
        end

        def reinitialize_git_repo
          Dir.chdir(@pod_dir) do
            `rm -rf .git`
            `git init`
            `git add -A`
            `git remote add origin #{@repo_url}`
          end
        end

        def farewell_message
          puts ""
    
          puts " Ace! you're ready to go!"
          puts " We will start you off by opening your project in Xcode"
          run_command "open '#{@pod_dir}/Example/#{@pod_name}.xcworkspace'"
        end

        def run_command command, output_command=nil
          output_command ||= command
    
          puts "  " + output_command.magenta
          system command
        end

        def ask(question)
          answer = ""
          loop do
            puts "\n#{question}"
            print " > ".green
            answer = gets.chomp
            answer = answer.strip
            if answer.length > 0
              break
            end
          end
          answer.to_s
        end
  
        def year
          Time.now.year.to_s
        end
  
        def month
          Time.now.month.to_s
        end
  
        def day
          Time.now.day.to_s
        end
  end
end
