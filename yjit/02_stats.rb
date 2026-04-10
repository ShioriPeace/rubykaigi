# Step 2: YJITの統計情報を見る
#
# 実行方法:
#   ruby --yjit --yjit-stats 02_stats.rb
#
# 終了時にYJITの統計が出力される。
# 「何%がYJITでコンパイルされたか」を見てみよう。

def calculate(n)
  total = 0
  n.times do |i|
    total += i * 2
    total -= 1 if i.odd?
  end
  total
end

def transform(array)
  array.map { |x| x.to_s }.select { |s| s.length > 1 }.join(", ")
end

puts "計算中..."
result1 = calculate(1_000_000)
result2 = transform((1..1000).to_a)

puts "calculate結果: #{result1}"
puts "transform結果の長さ: #{result2.length}文字"
puts
puts "--- この下にYJITの統計が出る（--yjit-stats つけた場合）---"
