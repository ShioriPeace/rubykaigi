# ZJIT: 次世代のJITコンパイラ

ZJITはYJITの「次世代版」。同じShopify/Rubyチームが開発してる。
Ruby 4.0 で初めて入った、まだ実験的な機能。

YJITとの違い: YJITは「バイトコード→機械語」を直接変換するけど、
ZJITは間に「中間表現（IR）」を挟むことで、もっと賢い最適化ができるようになる。

**今はまだYJITの方が速い。** でも将来的にはZJITがYJITを超える予定。
「次に来るやつ」を先に触っておこう。

---

## Step 0: セットアップ

```bash
cd ~/rubykaigi/zjit
rbenv local 4.0.1
ruby --version
# ruby 4.0.1 が出ればOK
```

ZJITが使えるか確認:

```bash
ruby --zjit -e "puts 'ZJIT is working!'"
```

---

## Step 1: YJIT vs ZJIT ベンチマーク（01_yjit_vs_zjit.rb）

同じ処理をYJIT・ZJIT・無しの3パターンで比較する。

```bash
# JIT無し
ruby 01_yjit_vs_zjit.rb

# YJIT
ruby --yjit 01_yjit_vs_zjit.rb

# ZJIT
ruby --zjit 01_yjit_vs_zjit.rb
```

3つの数字を見比べてみよう。

---

## Step 2: ZJITの中間表現を覗く（02_zjit_ir.rb）

ZJITの特徴は「中間表現（IR）」を持つこと。
`--zjit-ir` オプションで、コードがどんなIRに変換されるか見られる。

```bash
ruby --zjit --zjit-ir 02_zjit_ir.rb
```

YJITにはこのステップがない。ZJITはここで最適化のチャンスを見つける。

---

## Step 3: いろんな処理で比較してみる（03_various.rb）

配列操作、文字列操作、ハッシュ操作など、いろんなパターンで比較する。

```bash
ruby 03_various.rb
ruby --yjit 03_various.rb
ruby --zjit 03_various.rb
```

処理によって得意・不得意が違うのが見えるかも。

---

## ふりかえり

- **ZJIT** = YJITの次世代JITコンパイラ。Ruby 4.0で実験的に導入
- `ruby --zjit` で有効になる
- 今はYJITの方が速いけど、将来的にはZJITが主力になる予定
- 中間表現（IR）を持つことで、より賢い最適化ができる設計
- RubyKaigi 2025でMaxime Chevalier-Boisvertが発表した

YJITもZJITも「Rubyを速くしたい」という同じ目標。アプローチが違うだけ。
