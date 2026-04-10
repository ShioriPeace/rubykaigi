# Step 1: YJIT vs ZJIT ベンチマーク
#
# 実行方法:
#   ruby 01_yjit_vs_zjit.rb          ← JIT無し
#   ruby --yjit 01_yjit_vs_zjit.rb   ← YJIT
#   ruby --zjit 01_yjit_vs_zjit.rb   ← ZJIT
#
# 3つの結果を見比べてみよう。

require 'benchmark'

def fib(n)
  n <= 1 ? n : fib(n - 1) + fib(n - 2)
end

# どのJITが有効か表示
jit = if defined?(RubyVM::ZJIT) && RubyVM::ZJIT.enabled?
        "ZJIT"
      elsif defined?(RubyVM::YJIT) && RubyVM::YJIT.enabled?
        "YJIT"
      else
        "なし"
      end

puts "JIT: #{jit}"
puts "Ruby: #{RUBY_VERSION}"
puts

Benchmark.bm(12) do |x|
  x.report("fib(35)") { fib(35) }
end
