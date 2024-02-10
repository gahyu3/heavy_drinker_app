# frozen_string_literal: true

begin
  require 'hirb'
rescue LoadError => e
  # ログにエラーメッセージを出力するなどの適切なエラーハンドリングを行う
  puts "Error loading Hirb: #{e.message}"
end

if defined? Hirb
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end
