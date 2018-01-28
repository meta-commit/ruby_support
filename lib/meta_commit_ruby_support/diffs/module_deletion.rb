module MetaCommit::Extension::RubySupport::Diffs
  class ModuleDeletion < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_DELETION &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          (context.old_contextual_ast.target_node.is_module? || is_name_of_module?(context.old_contextual_ast))
    end

    def string_representation
      if change_context.old_contextual_ast.target_node.is_module?
        return "remove module #{change_context.old_contextual_ast.target_node.module_name}"
      end
      "remove module #{name_of_context_module(change_context.old_contextual_ast)}"
    end
  end
end