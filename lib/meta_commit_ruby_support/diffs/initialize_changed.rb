module MetaCommit::Extension::RubySupport::Diffs
  class InitializeChanged < Diff
    INITIALIZE_METHOD_NAME = 'initialize'

    def supports_change(context)
      context.type == MetaCommit::Extension::RubySupport::Diffs::Diff::TYPE_REPLACE &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          is_in_context_of_method?(context.old_contextual_ast) &&
          is_in_context_of_method?(context.new_contextual_ast) &&
          name_of_context_method(context.old_contextual_ast) == INITIALIZE_METHOD_NAME && name_of_context_method(context.new_contextual_ast) == INITIALIZE_METHOD_NAME
    end

    def string_representation
      "change initialization of #{path_to_component(change_context.new_contextual_ast, 0)}"
    end
  end
end