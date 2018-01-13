module MetaCommit::Extension::RubySupport::Diffs
  class ModuleCreation < Diff
    def supports_change(type, old_file_name, new_file_name, old_ast_path, new_ast_path)
      type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_ADDITION &&
          contextual_ast_has_target_node(new_ast_path) &&
          (new_ast_path.target_node.is_module? || is_name_of_module?(new_ast_path))
    end

    def string_representation
      if @new_ast_path.whole_file_change
        added_module=@new_ast_path.target_node
        created_class_names=added_module.classes.map do |class_ast|
          class_ast.class_name
        end
        # @TODO maybe invoke created class change
        return "#{created_class_names.join(',')} added to #{new_ast_path.target_node.module_name}" unless created_class_names.empty?
      end
      if @new_ast_path.target_node.is_module?
        return "created module #{new_ast_path.target_node.module_name}"
      end
      "created module #{name_of_context_module(new_ast_path)}"
    end
  end
end