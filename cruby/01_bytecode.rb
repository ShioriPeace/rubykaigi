# Step 2: バイトコードを見てみる
#
# RubyVM::InstructionSequence（略してISeq）は、
# Rubyのコードが「どんな命令に変換されるか」を見せてくれる。
#
# 難しく考えなくてOK。「へー、こうなるんだ」で十分。

puts "=== シンプルな足し算 ==="
puts
code = "1 + 2"
puts "Rubyコード: #{code}"
puts
puts "↓ これがバイトコード（VMへの命令）:"
puts RubyVM::InstructionSequence.compile(code).disasm
puts

puts "=== 変数への代入 ==="
puts
code = "x = 1 + 2"
puts "Rubyコード: #{code}"
puts
puts "↓ バイトコード:"
puts RubyVM::InstructionSequence.compile(code).disasm
puts

puts "=== メソッド呼び出し ==="
puts
code = 'puts "hello"'
puts "Rubyコード: #{code}"
puts
puts "↓ バイトコード:"
puts RubyVM::InstructionSequence.compile(code).disasm
puts

puts "---"
puts "putobject = 値を置く"
puts "opt_plus = 足し算する"
puts "setlocal = 変数に入れる"
puts "opt_send_without_block = メソッドを呼ぶ"
puts
puts "全部覚えなくていい。「Rubyは裏側でこういう命令に分解してるんだな」でOK！"
