# Step 2: ZJITの中間表現（IR）を覗く
#
# 実行方法:
#   ruby --zjit --zjit-ir 02_zjit_ir.rb
#
# ZJITがコードをどう解析しているか、中間表現が表示される。
# 全部理解する必要はない。「こんなステップを経てるんだ」でOK。

def add(a, b)
  a + b
end

def double(n)
  n * 2
end

# メソッドを呼びまくって、ZJITにコンパイルさせる
result = 0
100_000.times do |i|
  result = add(result, double(i))
end

puts "結果: #{result}"
puts
puts "↑ の上に --zjit-ir の出力が出ていたら、それがZJITの中間表現。"
puts "YJITにはこのステップがない。ZJITはここで最適化を考える。"
