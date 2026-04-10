# Step 3: Prism パーサーを直接使う
#
# Prism = Ruby 3.4からデフォルトになった新しいパーサー。
# RubyVM::AbstractSyntaxTree よりも詳しい情報が見える。

require 'prism'

puts "=== Prismで「1 + 2」を解析 ==="
puts
result = Prism.parse("1 + 2")
pp result.value
puts

puts "=== ノードの種類を見る ==="
puts
node = result.value                          # ProgramNode
statements = node.statements                 # StatementsNode
expression = statements.body.first           # CallNode（足し算）

puts "ノードの種類: #{expression.class}"
puts "メソッド名:   #{expression.name}"       # :+
puts "レシーバ:     #{expression.receiver}"   # 1（IntegerNode）
puts "引数:         #{expression.arguments}"  # 2（IntegerNode）
puts

puts "=== もうちょっと複雑なコード ==="
puts
code = <<~RUBY
  def greet(name)
    puts "Hello, \#{name}!"
  end
RUBY

puts "コード:"
puts code
puts "Prismの解析結果:"
pp Prism.parse(code).value
puts

puts "=== ソースコードの位置情報 ==="
puts
code = "x = 1 + 2"
result = Prism.parse(code)
node = result.value.statements.body.first

puts "コード: #{code}"
puts "このノードの位置: #{node.location.start_offset}〜#{node.location.end_offset}"
puts
puts "→ Prismは「コードのどこにあるか」の位置情報も持ってる"
puts "  エディタの「定義にジャンプ」機能もこれを使ってる"
