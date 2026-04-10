# Step 1: YJITあり・なしで速度を比較する
#
# 実行方法:
#   ruby 01_benchmark.rb          ← YJIT無し
#   ruby --yjit 01_benchmark.rb   ← YJIT有り
#
# 数字が小さいほど速い。

require 'benchmark'

# フィボナッチ数列（再帰）
# メソッド呼び出しが大量に発生する → YJITの得意分野
def fib(n)
  if n <= 1
    n
  else
    fib(n - 1) + fib(n - 2)
  end
end

yjit_status = defined?(RubyVM::YJIT) && RubyVM::YJIT.enabled? ? "有効" : "無効"
puts "YJIT: #{yjit_status}"
puts

Benchmark.bm(12) do |x|
  x.report("fib(35)") { fib(35) }
  x.report("fib(37)") { fib(37) }
end
