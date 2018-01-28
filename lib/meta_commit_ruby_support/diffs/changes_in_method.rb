module MetaCommit::Extension::RubySupport::Diffs
  class ChangesInMethod < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE &&
          contextual_ast_has_target_node(context.old_contextual_ast) && contextual_ast_has_target_node(context.new_contextual_ast) &&
          is_in_context_of_method?(context.old_contextual_ast) && is_in_context_of_method?(context.new_contextual_ast)
    end

    def string_representation
      if is_in_context_of_class?(change_context.new_contextual_ast)
        return "changes in #{name_of_context_class(change_context.new_contextual_ast)}##{name_of_context_method(change_context.new_contextual_ast)}"
      end
      "changes in ##{name_of_context_method(change_context.new_contextual_ast)}"
    end
  end
end