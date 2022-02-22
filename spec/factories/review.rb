FactoryBot.define do
  factory :review do
    rate { 5.0 }
    comment { "Rpsecコメント" }
  end

  factory :four_rate, class: Review do
    rate { 4.0 }
    comment { "評価は4点です。" }
  end

  factory :three_rate, class: Review do
    rate { 2.5 }
    comment { "良くも悪くも2.5点ですね。" }
  end
end
