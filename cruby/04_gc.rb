# Step 5: GC（ガベージコレクション）を観察する
#
# 使わなくなったオブジェクトを自動的に片付けてくれる仕組み = GC
# GC.stat で今のメモリの状態が見える

puts "=== GCの状態を見る ==="
puts

before = GC.stat
puts "GC実行回数: #{before[:count]}"
puts "ヒープ内のオブジェクト数: #{before[:heap_live_slots]}"
puts

puts "=== 大量にオブジェクトを作る ==="
puts

# 10万個の文字列オブジェクトを作る（変数に入れないのでGC対象になる）
100_000.times { "hello world" * 10 }

after = GC.stat
puts "GC実行回数: #{after[:count]}（さっきは #{before[:count]}）"
puts "→ #{after[:count] - before[:count]} 回GCが走った！"
puts

puts "=== ObjectSpace で数えてみる ==="
puts

require 'objspace'

# 今生きてるオブジェクトをクラスごとに数える
counts = Hash.new(0)
ObjectSpace.each_object { |obj| counts[obj.class] += 1 }

puts "クラス別オブジェクト数（上位10）:"
counts.sort_by { |_k, v| -v }.first(10).each do |klass, count|
  puts "  #{klass}: #{count}"
end
puts

puts "=== GCを手動で呼ぶ ==="
puts

# わざと大量の配列を作る
arrays = Array.new(50_000) { [1, 2, 3] }
puts "配列を5万個作った → オブジェクト数: #{GC.stat[:heap_live_slots]}"

# 参照を消す
arrays = nil

# GCを手動実行
GC.start

puts "参照を消してGCした → オブジェクト数: #{GC.stat[:heap_live_slots]}"
puts
puts "→ 誰からも参照されなくなったオブジェクトをGCが片付けてくれた"
