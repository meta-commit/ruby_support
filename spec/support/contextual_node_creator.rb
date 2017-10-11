class ContextualNodeCreator

  # @param [MetaCommit::Contracts::Ast] source_ast
  # @param [Integer] line_number
  # @return [MetaCommit::Contracts::ContextualAst]
  def create_ast_path(source_ast, line_number)
    visited_nodes = []
    ast_path = MetaCommit::Contracts::ContextualAst.new
    ast_path.parser_class = source_ast.parser_class
    ast_path.target_node = collect_path_to_ast_at_line(source_ast, line_number, visited_nodes)
    ast_path.context_nodes = visited_nodes
    ast_path
  end

  # @param [MetaCommit::Contracts::Ast] ast
  # @param [Integer] lineno
  # @param [Array<MetaCommit::Contracts::Ast>] accumulator
  # @return [MetaCommit::Contracts::Ast]
  def collect_path_to_ast_at_line(ast, lineno, accumulator)
    return nil if ast.nil? or not covers_line(ast, lineno)
    closest_ast = ast
    accumulator.push(closest_ast)
    ast.children.each do |child|
      found_ast = collect_path_to_ast_at_line(child, lineno, accumulator)
      closest_ast = found_ast unless found_ast.nil?
    end
    closest_ast
  end

  protected :collect_path_to_ast_at_line


  # @param [MetaCommit::Contracts::Ast] ast
  # @param [Integer] lineno
  # @return [MetaCommit::Contracts::Ast]
  def get_ast_at_line(ast, lineno)
    return nil unless covers_line(ast, lineno)
    closest_ast = ast
    ast.children.each do |child|
      found_ast = get_ast_at_line(child, lineno)
      closest_ast = found_ast unless found_ast.nil?
    end
    closest_ast
  end

  protected :get_ast_at_line


  # @param [MetaCommit::Contracts::Ast] ast
  # @param [Integer] line
  # @return [Boolean]
  def covers_line(ast, line)
    return false if ((ast.first_line.nil?) && (ast.last_line.nil?))
    ((ast.first_line <= line) && (ast.last_line >= line))
  end

  protected :covers_line
end