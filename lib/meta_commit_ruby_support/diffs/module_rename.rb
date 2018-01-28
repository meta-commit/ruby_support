module MetaCommit::Extension::RubySupport::Diffs
  class ModuleRename < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          is_name_of_module?(context.old_contextual_ast) &&
          is_name_of_module?(context.new_contextual_ast)
    end

    def string_representation
      "rename module #{name_of_context_module(change_context.old_contextual_ast)} to #{name_of_context_module(change_context.new_contextual_ast)}"
    end
  end
end