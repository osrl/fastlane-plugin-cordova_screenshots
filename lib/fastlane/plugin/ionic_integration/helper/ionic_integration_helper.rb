require 'fastlane/plugin/ionic_integration/constants'

module Fastlane
  module Helper
    class IonicIntegrationHelper
      HELPER_PATH = File.expand_path(File.dirname(__FILE__))

      IOS_RESOURCES_PATH = File.expand_path("#{HELPER_PATH}/../resources/ios")

      #
      # Copy over to the xcode project our pre-configured UI Test Code
      #
      def self.copy_ios_ui_test_code(src_folder, project_folder)
        if src_folder && Dir.exist?(src_folder)
          dest_folder = project_folder.to_s
          UI.message "Copying iOS UI Tests from #{src_folder} to #{dest_folder}"
          Dir.exist?(dest_folder) || FileUtils.mkdir_p(dest_folder)
          FileUtils.cp_r(src_folder + "/.", dest_folder)
        elsif
          UI.user_error! "Copying iOS UI Test Files: #{src_folder} does not exist."
        end
      end

      def self.copy_ios_sample_tests(scheme_name)
        source_folder = "#{IOS_RESOURCES_PATH}/#{IonicIntegration::IONIC_DEFAULT_UNIT_TEST_NAME}"
        dest_folder = "#{IonicIntegration::IONIC_IOS_CONFIG_UITESTS_PATH}/#{scheme_name}"
        copy_ios_ui_test_code(source_folder, dest_folder)
      end

      #
      # Find any existing Xcode Workspace generated by Ionic/Cordova
      #
      def self.find_default_ios_xcode_workspace
        Dir["#{IonicIntegration::IONIC_IOS_BUILD_PATH}/*.xcodeproj"].last || nil
      end
    end
  end
end
