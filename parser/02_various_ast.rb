# Step 2: いろんなコードのASTを比較する
#
# コードの種類によってASTの形が変わる。

def show_tree(node, indent = 0)
  prefix = "  " * indent
  if node.is_a?(RubyVM::AbstractSyntaxTree::Node)
    puts "#{prefix}#{node.type}"
    node.children.each { |child| show_tree(child, indent + 1) }
  else
    puts "#{prefix}=> #{node.inspect}" unless node.nil?
  end
end

def show(title, code)
  puts "=== #{title} ==="
  puts "コード: #{code}"
  puts
  show_tree(RubyVM::AbstractSyntaxTree.parse(code))
  puts
end

# 変数代入
show("変数代入", "x = 42")

# if文
show("if文", "if x > 0 then 'positive' else 'negative' end")

# メソッド定義
show("メソッド定義", "def greet(name); puts name; end")

# 配列操作
show("配列操作", "[1, 2, 3].map { |n| n * 2 }")

puts "---"
puts "SCOPE = スコープ（変数の範囲）"
puts "LASGN = ローカル変数への代入"
puts "IF = 条件分岐"
puts "DEFN = メソッド定義"
puts "ITER = ブロック付きメソッド呼び出し"
puts
puts "→ 普段なにげなく書いてるRubyコードも、"
puts "  裏側ではこういう構造として解析されてる"
