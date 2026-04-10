# Step 3: メソッド呼び出しが多いと効く
#
# 実行方法:
#   ruby 03_method_calls.rb          ← YJIT無し
#   ruby --yjit 03_method_calls.rb   ← YJIT有り
#
# Rubyはメソッド呼び出しのコストが高い。
# YJITはここを特に最適化してくれる。

require 'benchmark'

class Calculator
  def add(a, b) = a + b
  def sub(a, b) = a - b
  def mul(a, b) = a * b

  def complex_calc(n)
    result = 0
    n.times do |i|
      result = add(result, mul(i, 2))
      result = sub(result, 1)
    end
    result
  end
end

class StringProcessor
  def process(str)
    upcase(reverse(trim(str)))
  end

  private

  def trim(str) = str.strip
  def reverse(str) = str.reverse
  def upcase(str) = str.upcase
end

yjit_status = defined?(RubyVM::YJIT) && RubyVM::YJIT.enabled? ? "有効" : "無効"
puts "YJIT: #{yjit_status}"
puts

calc = Calculator.new
proc = StringProcessor.new

Benchmark.bm(20) do |x|
  x.report("Calculator") { calc.complex_calc(1_000_000) }
  x.report("StringProcessor") { 100_000.times { proc.process("  hello world  ") } }
end
