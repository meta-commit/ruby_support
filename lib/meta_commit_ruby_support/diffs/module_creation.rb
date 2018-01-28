module MetaCommit::Extension::RubySupport::Diffs
  class ModuleCreation < Diff
    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_ADDITION &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          (context.new_contextual_ast.target_node.is_module? || is_name_of_module?(context.new_contextual_ast))
    end

    def string_representation
      if change_context.new_contextual_ast.whole_file_change
        added_module=change_context.new_contextual_ast.target_node
        created_class_names=added_module.classes.map do |class_ast|
          class_ast.class_name
        end
        # @TODO maybe invoke created class change
        return "#{created_class_names.join(',')} added to #{change_context.new_contextual_ast.target_node.module_name}" unless created_class_names.empty?
      end
      if change_context.new_contextual_ast.target_node.is_module?
        return "create module #{change_context.new_contextual_ast.target_node.module_name}"
      end
      "create module #{name_of_context_module(change_context.new_contextual_ast)}"
    end
  end
end