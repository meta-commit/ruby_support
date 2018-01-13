module MetaCommit::Extension::RubySupport::Helpers
  module ContextualAstAccessor
    # @param [Object] ast
    # @param [Integer] depth
    # @return [String]
    def path_to_component(ast, depth=nil)
      depth = -1 if depth.nil?
      result = []
      result.concat([name_of_context_module(ast), is_in_context_of_class?(ast) && depth < 1 ? '::' : '']) if is_in_context_of_module?(ast) && depth < 2
      result.concat([name_of_context_class(ast)]) if is_in_context_of_class?(ast) && depth < 1
      result.concat(['#', name_of_context_method(ast)]) if is_in_context_of_method?(ast) && depth < 0
      result.join('')
    end

    # on created class only first line goes to diff
    # @param [MetaCommit::Model::ContextualAstNode] ast
    def is_name_of_class?(ast)
      (ast.target_node.ast.type == :const) and (ast.context_nodes.length > 1) and (ast.context_nodes[ast.context_nodes.length - 1 - 1].ast.type == :class)
    end

    # on created module only first line goes to diff
    # @param [MetaCommit::Model::ContextualAstNode] ast
    def is_name_of_module?(ast)
      (ast.target_node.ast.type == :const) and (ast.context_nodes.length > 1) and (ast.context_nodes[ast.context_nodes.length - 1 - 1].ast.type == :module)
    end

    # @param [MetaCommit::Model::ContextualAstNode] ast
    def name_of_context_module(ast)
      ast.context_nodes.reverse.each do |parent|
        return parent.module_name if parent.is_module?
      end
    end

    # @param [MetaCommit::Model::ContextualAstNode] ast
    def name_of_context_class(ast)
      ast.context_nodes.reverse.each do |parent|
        return parent.class_name if parent.is_class?
      end
    end

    # @param [MetaCommit::Model::ContextualAstNode] ast
    def name_of_context_method(ast)
      ast.context_nodes.reverse.each do |parent|
        return parent.method_name if parent.is_method?
      end
    end

    # @param [MetaCommit::Model::ContextualAstNode] ast
    # @return [Boolean]
    def is_in_context_of_module?(ast)
      ast.context_nodes.each do |parent|
        return true if parent.is_module?
      end
      false
    end

    # @param [MetaCommit::Model::ContextualAstNode] ast
    # @return [Boolean]
    def is_in_context_of_class?(ast)
      ast.context_nodes.each do |parent|
        return true if parent.is_class?
      end
      false
    end

    # @param [MetaCommit::Model::ContextualAstNode] ast
    # @return [Boolean]
    def is_in_context_of_method?(ast)
      ast.context_nodes.each do |parent|
        return true if parent.is_method?
      end
      false
    end

    def contextual_ast_has_target_node(ast)
      !ast.target_node.nil? && !ast.target_node.empty_ast?
    end
  end
end