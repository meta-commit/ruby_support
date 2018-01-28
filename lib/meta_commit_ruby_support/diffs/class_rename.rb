module MetaCommit::Extension::RubySupport::Diffs
  class ClassRename < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          is_name_of_class?(context.old_contextual_ast) && is_name_of_class?(context.new_contextual_ast)
    end

    def string_representation
      "rename class #{name_of_context_class(change_context.old_contextual_ast)} to #{name_of_context_class(change_context.new_contextual_ast)}"
    end
  end
end