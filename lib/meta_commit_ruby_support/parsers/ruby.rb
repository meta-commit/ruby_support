require "parser/current"

module MetaCommit::Extension::RubySupport::Parsers
  class Ruby < MetaCommit::Contracts::Parser

    # @return [Array<String>]
    def self.supported_file_extensions
      ['.rb']
    end

    # @return [Boolean]
    def self.supports_syntax?(source_code)
      begin
        Parser::CurrentRuby.parse(source_code)
      rescue Parser::SyntaxError
        return false
      end
      true
    end

    # @param [String] source_code
    # @return [MetaCommit::Extension::RubySupport::Models::Ast]
    def parse(source_code)
      begin
        parsed_ast = parser.parse(source_code)
        MetaCommit::Extension::RubySupport::Models::Ast.new(parsed_ast)
      rescue Parser::SyntaxError
        raise MetaCommit::Contracts::Errors::SourceCodeParsingError.new("can't parse '#{source_code}' using #{self.class}")
      end
    end

    def parser
      @parser ||= Parser::CurrentRuby
    end

    protected :parser
  end
end