module MetaCommit::Extension::RubySupport::Diffs
  # Base class for diffs
  class Diff < MetaCommit::Contracts::Diff
    include MetaCommit::Extension::RubySupport::Helpers::ContextualAstAccessor

    SUPPORTED_PARSERS = [MetaCommit::Extension::RubySupport::Parsers::Ruby]

    # @param [Class] parser
    # @return [Boolean]
    def supports_parser?(parser)
      SUPPORTED_PARSERS.include?(parser)
    end

    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      true
    end

    # @return [String]
    def inspect
      string_representation
    end

    # @return [String]
    def to_s
      string_representation
    end

    # @return [String]
    def string_representation
      "perform #{change_context.type}"
    end

    # @return [Boolean]
    def type_addition?
      change_context.type == TYPE_ADDITION
    end

    # @return [Boolean]
    def type_deletion?
      change_context.type == TYPE_DELETION
    end

    # @return [Boolean]
    def type_replace?
      change_context.type == TYPE_REPLACE
    end
  end
end