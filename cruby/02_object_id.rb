# Step 3: オブジェクトの正体を調べる
#
# Rubyでは全てがオブジェクト。
# object_id でそのオブジェクト固有のIDが分かる。

puts "=== 数字のobject_id ==="
puts
puts "1.object_id = #{1.object_id}"
puts "2.object_id = #{2.object_id}"
puts "3.object_id = #{3.object_id}"
puts "100.object_id = #{100.object_id}"
puts
puts "→ 小さい整数は毎回同じID。Rubyが使い回してメモリを節約してる。"
puts

puts "=== 文字列のobject_id ==="
puts
a = "hello"
b = "hello"
puts "a = \"hello\"  → object_id: #{a.object_id}"
puts "b = \"hello\"  → object_id: #{b.object_id}"
puts "同じ内容でもIDが違う！ = 別のオブジェクトとして毎回作られてる"
puts

puts "=== シンボルのobject_id ==="
puts
puts ":hello.object_id = #{:hello.object_id}"
puts ":hello.object_id = #{:hello.object_id}"
puts "→ シンボルは同じ名前なら常に同じID。だからハッシュのキーに向いてる。"
puts

puts "=== nil, true, false ==="
puts
puts "nil.object_id   = #{nil.object_id}"
puts "true.object_id  = #{true.object_id}"
puts "false.object_id = #{false.object_id}"
puts "→ これらは特別なオブジェクト。IDが決まってる。"
puts

puts "=== クラスを調べる ==="
puts
puts "1.class       = #{1.class}"
puts "\"hello\".class = #{"hello".class}"
puts "[1,2].class   = #{[1, 2].class}"
puts "nil.class     = #{nil.class}"
puts
puts "→ 全てがオブジェクト = 全てにクラスがある。メソッドが呼べる。"
