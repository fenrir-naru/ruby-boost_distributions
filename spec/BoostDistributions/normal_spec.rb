# frozen_string_literal: true

RSpec.describe BoostDistributions::Normal do
  describe "normal distribution" do
    let(:normal){BoostDistributions::Normal}
    it "can perform demo calculation" do
      # Ruby version of https://github.com/boostorg/math/blob/HEAD/example/normal_misc_examples.cpp
      s = normal::new
      expect(s.mean).to eq(0)
      expect(s.standard_deviation).to eq(1)

      (-4..4).step(1){|z| # pdf
        expect(s.pdf(z)).to be_within(1E-6).of({
          -4 => 0.00013383022576488537,
          -3 => 0.0044318484119380075,
          -2 => 0.053990966513188063,
          -1 => 0.24197072451914337,
          0 => 0.3989422804014327,
          1 => 0.24197072451914337,
          2 => 0.053990966513188063,
          3 => 0.0044318484119380075,
          4 => 0.00013383022576488537,
        }[z])
      }
      (-4..4).step(1){|z| # cdf
        expect(s.cdf(z)).to be_within(1E-6).of({
          -4 => 3.1671241833119979e-005,
          -3 => 0.0013498980316300959,
          -2 => 0.022750131948179219,
          -1 => 0.1586552539314571,
          0 => 0.5,
          1 => 0.84134474606854293,
          2 => 0.97724986805182079,
          3 => 0.9986501019683699,
          4 => 0.99996832875816688,
        }[z])
      }
      expect(s.quantile(0.95)).to be_within(5E-6).of(1.64485)
      expect(s.quantile(0.975)).to be_within(5E-6).of(1.95996)
      expect(s.cdf(-1) * 2).to be_within(1E-6).of(0.3173105078629142)
      [0.3173105078629142, 0.20, 0.1,
          0.05, 0.01, 0.001, 0.0001, 0.00001].each.with_index{|alpha, i|
        expect(s.quantile(alpha / 2, true)).to be_within(1E-3).of([
          1, 1.282, 1.645, 1.96, 2.576, 3.291, 3.891, 4.417
        ][i])
      }
      expect(s.cdf(s.standard_deviation)).to be_within(5E-4).of(0.841)
      expect(s.cdf(s.standard_deviation, true)).to be_within(5E-4).of(0.159)
      expect(1.0 - s.cdf(s.standard_deviation(), true) * 2).to be_within(5E-4).of(0.683)
      expect(1.0 - s.cdf(s.standard_deviation() * 2, true) * 2).to be_within(5E-4).of(0.954)
      expect(1.0 - s.cdf(s.standard_deviation() * 3, true) * 2).to be_within(5E-4).of(0.997)
      
      bulbs = normal::new(1100, 100)
      expect(bulbs.cdf(1000)).to be_within(5E-4).of(0.159)
      expect(bulbs.cdf(1000, true)).to be_within(5E-4).of(0.841)
      expect(bulbs.cdf(1200) - bulbs.cdf(900)).to be_within(5E-4).of(0.819)
      
      sacks = normal::new(140, 10)
      expect(sacks.cdf(160) * 100).to be_within(5E-2).of(97.7)
      expect(sacks.quantile(0.95).to_i).to eq(156)
      expect(sacks.quantile(0.80).to_i).to eq(148)

      packs = normal::new(3, 0.1)
      expect(packs.cdf(3.1, true)).to be_within(5E-4).of(0.159)
      expect(packs.cdf(2.9, true)).to be_within(5E-4).of(0.841)

      xpacks = normal::new(3.0664, 0.1);
      expect(xpacks.cdf(2.9, true)).to be_within(5E-2).of(0.952)

      nominal_mean = 3 * 2 - 0.1 - packs.quantile(0.05)
      expect(nominal_mean).to be_within(5E-3).of(3.06)
      nominal_packs = normal::new(nominal_mean, 0.1)
      expect(nominal_packs.cdf(2.9, true)).to be_within(5E-4).of(0.950)
      
      expect(packs.quantile(0.05)).to be_within(5E-3).of(2.84)

      pack05 = normal::new(3, 0.05)
      expect(pack05.quantile(0.05)).to be_within(5E-3).of(2.92)
      expect(pack05.cdf(2.9, true)).to be_within(5E-4).of(0.977)
        
      pack06 = normal::new(3, 0.06)
      expect(pack06.quantile(0.05)).to be_within(5E-3).of(2.90)
      expect(pack06.cdf(2.9, true)).to be_within(5E-4).of(0.952)
      
      prob = s.pdf((2.9 - 3) / 0.1)
      expect(prob).to be_within(5E-4).of(0.242)
      qp = s.quantile(0.95)
      expect(qp).to be_within(5E-3).of(1.64)
      sd95 = ((2.9 - 3) / qp).abs
      expect(sd95).to be_within(5E-5).of(0.0608)
      
      pack95 = normal::new(3, sd95)
      expect(pack95.cdf(2.9, true)).to be_within(5E-4).of(0.950)

      bolts = normal::new(3.95, 0.1)
      expect(bolts.cdf(4.1)).to be_within(5E-4).of(0.933)
      expect(bolts.cdf(3.9)).to be_within(5E-4).of(0.309)
      expect(bolts.cdf(4.1) - bolts.cdf(3.9)).to be_within(5E-4).of(0.625)
      expect(bolts.cdf(4.1, true)).to be_within(5E-5).of(0.0668)
      expect(bolts.quantile(0.95)).to be_within(5E-3).of(4.11)
    end
  end if BoostDistributions::BOOST_VERSION >= 103500
end
