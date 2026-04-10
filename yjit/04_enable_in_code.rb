# Step 4: コード内からYJITを有効にする
#
# 実行方法:
#   ruby 04_enable_in_code.rb   ← --yjit フラグ不要！
#
# RubyVM::YJIT.enable で途中から有効にできる。
# Railsアプリでは config/application.rb でこれを呼ぶのが一般的。

require 'benchmark'

def fib(n)
  n <= 1 ? n : fib(n - 1) + fib(n - 2)
end

puts "=== YJITを有効にする前 ==="
puts "YJIT: #{RubyVM::YJIT.enabled? ? "有効" : "無効"}"
time_before = Benchmark.measure { fib(35) }
puts "fib(35): #{time_before}"

puts
puts "=== RubyVM::YJIT.enable を呼ぶ ==="
RubyVM::YJIT.enable
puts "YJIT: #{RubyVM::YJIT.enabled? ? "有効" : "無効"}"

puts
puts "=== YJITを有効にした後 ==="
time_after = Benchmark.measure { fib(35) }
puts "fib(35): #{time_after}"

puts
puts "→ 同じコードでも、YJITが有効な方が速いはず"
puts
puts "Railsアプリでの使い方:"
puts '  # config/application.rb'
puts '  RubyVM::YJIT.enable'
