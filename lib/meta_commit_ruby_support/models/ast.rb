module MetaCommit::Extension::RubySupport::Models
  # Adapter which implements MetaCommit::Contracts::Ast contract and wraps Parser::AST::Node
  # @attr [Array<Parser::AST::Node>] ast
  class Ast < MetaCommit::Contracts::Ast
    attr_reader :ast

    # @param [Parser::AST::Node] ast
    def initialize(ast)
      @ast = ast
    end

    # @return [Array<MetaCommit::Contracts::Ast>]
    def children
      begin
        @ast.children
            .map {|child| Ast.new(child)}
      rescue NoMethodError
        return []
      end
    end

    # @return [Integer]
    def first_line
      return unless @ast.respond_to?(:location)
      begin
        return @ast.location.first_line
      rescue NoMethodError
        return nil
      end
    end

    # @return [Integer]
    def last_line
      return unless @ast.respond_to?(:location)
      begin
        return @ast.location.last_line
      rescue NoMethodError
        return nil
      end
    end

    # @return [Boolean]
    def empty_ast?
      @ast.nil?
    end

    # @return [Boolean]
    def is_module?
      type == :module
    end

    # @return [Boolean]
    def is_class?
      type == :class
    end

    # @return [Boolean]
    def is_method?
      type == :def
    end

    # @return [Symbol]
    def type
      return @ast.class.to_s.to_sym unless @ast.respond_to?(:type)
      @ast.type
    end

    # @return [String]
    def module_name
      @ast.children.first.children.last.to_s
    end

    # @return [String]
    def class_name
      @ast.children.first.children.last.to_s
    end

    # @return [String]
    def method_name
      @ast.children.first.to_s
    end

    # @return [Array<Ast>]
    def classes
      accumulator=[]
      begin
        return if empty_ast?
        return self if is_class?
        accumulator.concat(children.map {|child| child.classes})
      rescue NoMethodError
        return nil
      end
      accumulator.flatten.compact
    end

    def to_s
      @ast.to_s
    end
  end
end