# Step 3: いろんな処理で比較してみる
#
# 実行方法:
#   ruby 03_various.rb
#   ruby --yjit 03_various.rb
#   ruby --zjit 03_various.rb

require 'benchmark'

jit = if defined?(RubyVM::ZJIT) && RubyVM::ZJIT.enabled?
        "ZJIT"
      elsif defined?(RubyVM::YJIT) && RubyVM::YJIT.enabled?
        "YJIT"
      else
        "なし"
      end

puts "JIT: #{jit}"
puts

Benchmark.bm(16) do |x|
  # 配列操作
  x.report("Array#map") do
    100.times { (1..10_000).to_a.map { |n| n * 2 } }
  end

  # 文字列操作
  x.report("String操作") do
    100_000.times { "hello world".upcase.reverse.chars.sort.join }
  end

  # ハッシュ操作
  x.report("Hash操作") do
    100.times do
      h = {}
      10_000.times { |i| h[i] = i.to_s }
      h.values.select { |v| v.length > 2 }
    end
  end

  # メソッドチェーン
  x.report("メソッドチェーン") do
    100_000.times { [1, 2, 3, 4, 5].select(&:odd?).map { |n| n ** 2 }.sum }
  end
end
