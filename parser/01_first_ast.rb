# Step 1: ASTを見てみる
#
# AST = Abstract Syntax Tree（抽象構文木）
# コードを「木の形」で表したもの。

puts "=== 「1 + 2」のAST ==="
puts
ast = RubyVM::AbstractSyntaxTree.parse("1 + 2")
pp ast
puts
puts "→ 1 + 2 は実は「1に対して + メソッドを2を引数にして呼ぶ」という構造"
puts

puts "=== もうちょっと見やすく ==="
puts

# ASTを再帰的に表示する関数
def show_tree(node, indent = 0)
  prefix = "  " * indent
  if node.is_a?(RubyVM::AbstractSyntaxTree::Node)
    puts "#{prefix}#{node.type}"
    node.children.each { |child| show_tree(child, indent + 1) }
  else
    puts "#{prefix}=> #{node.inspect}" unless node.nil?
  end
end

puts "「1 + 2」:"
show_tree(RubyVM::AbstractSyntaxTree.parse("1 + 2"))
puts
puts "「puts 'hello'」:"
show_tree(RubyVM::AbstractSyntaxTree.parse("puts 'hello'"))
puts
puts "→ コードが木の形になってるのが見える"
puts "  OPCALL = 演算子の呼び出し"
puts "  FCALL = 関数（メソッド）の呼び出し"
puts "  LIT / STR = 数値や文字列のリテラル"
