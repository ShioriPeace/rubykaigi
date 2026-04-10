# YJIT: Rubyを速くするJITコンパイラ

YJITは **Rubyのコードを実行中に機械語に変換して速くする仕組み**。
ShopifyのチームがRustで作った。Ruby 3.1で入り、今も進化し続けてる。

「JITって何？」→ 気にしなくてOK。
**「--yjit つけると速くなる」** を体感するのがこのチュートリアルの目的。

---

## Step 0: セットアップ

```bash
cd ~/rubykaigi/yjit
rbenv local 4.0.1
ruby --version
```

YJITが使えるか確認:

```bash
ruby --yjit -e "puts RubyVM::YJIT.enabled?"
# true が出ればOK
```

---

## Step 1: まずは速度を比較する（01_benchmark.rb）

同じ処理を「YJIT無し」と「YJIT有り」で実行して、速度を比較する。

```bash
# YJIT無し
ruby 01_benchmark.rb

# YJIT有り
ruby --yjit 01_benchmark.rb
```

数字が小さいほど速い。差が出るはず。

---

## Step 2: なぜ速くなるのか見る（02_stats.rb）

`--yjit-stats` をつけると、YJITが何をしたか統計情報を出してくれる。

```bash
ruby --yjit --yjit-stats 02_stats.rb
```

「何%のコードがYJITでコンパイルされたか」が見える。

---

## Step 3: メソッド呼び出しが多いと効く（03_method_calls.rb）

YJITが特に得意なのは **メソッド呼び出しが多い処理**。
Rubyはメソッド呼び出しのコストが高いので、ここを最適化すると大きく効く。

```bash
ruby 03_method_calls.rb
ruby --yjit 03_method_calls.rb
```

---

## Step 4: コード内からYJITを有効にする（04_enable_in_code.rb）

`--yjit` フラグを使わなくても、コードの中からYJITを有効にできる。
Railsアプリではこの方法が一般的。

```bash
ruby 04_enable_in_code.rb
```

---

## ふりかえり

- **YJIT** = Yet Another JIT。Rubyを実行中に速くする仕組み
- `ruby --yjit` で有効になる
- メソッド呼び出しが多い処理で特に効果が大きい
- `--yjit-stats` で統計が見える
- `RubyVM::YJIT.enable` でコード内から有効化もできる
- Railsアプリでは15〜25%のスループット向上が報告されてる

次のZJITは、このYJITの「次世代版」。
