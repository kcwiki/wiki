--Categories:
--[[Category:Seasonal modules]]

return {
  index = {
    ["Destroyers"] = { "Yamakaze", "Asakaze", "Matsukaze", "Minazuki", "Fujinami", "Uranami" },
    ["Heavy Cruisers"] = { "Mogami" },
    ["Battleships"] = { "Yamato", "Warspite", "Gangut" },
    ["Light Carriers"] = { "Kasuga Maru" },
    ["Standard Carriers"] = { "Saratoga", "Aquila" },
    ["Auxiliaries"] = { "Kamoi", "Shimushu", "Kunashiri", "Etorofu" },
  },
  ships = {
    ["Yamakaze"] = {
      {
        ja = "この季節は嫌い。理屈はないの。体が動かなくなるような。ううん。ごめん。",
        en = "I hate this season. I don’t have any particular reason, it's just that my body feels like it can’t move. No, I’m sorry.",
      },
    },
    ["Asakaze"] = {
      {
        ja = "もう... 最近、雨ばっかりでやんなっちゃう。ま、雨の朝ってのもありっちゃありかな。ねえ、司令官はどう思う？お、司令官？",
        en = "Geez... we’ve had nothing but rain lately. I wonder if it will be still be raining in a couple days too. Hey, Commander, what do you think? Oh, Commander?",
      },
    },
    ["Matsukaze"] = {
      {
        ja = "そうだな、僕らしくもないが。この季節は色々考える。考えても、答えが出るわけでもないんだ。うふふ、まあいいじゃないか？そんなこともあるのさ。",
        en = "That’s right, this isn’t like me at all. This season makes me have all sorts of thoughts. And despite all this thinking, I’m not finding any answers. *giggle* Well, that’s fine too, isn’t it? It’s like that sometimes.",
        note = "Maybe it's because Matsukaze sank around this time?",
      },
    },
    ["Minazuki"] = {
      {
        ja = "この季節は... 苦手だね。うん、なんかね、気分があまり乗らないんだ。あ、もちろん、任務とあらば出撃するよ。それはうん、心配しないでいいよ。えへへ...",
        en = "This season….I don’t like it. Yeah, somehow I just can’t keep my spirits up. Of course, I’ll do my best to stay cheerful. You don’t have to worry about me. Heh heh….",
        note = "Minazuki sank around this time, on June 6, 1944.",
      },
    },
    ["Fujinami"] = {
      {
        ja = "よく降るねえ... まあ、仕方ないけど。おお、その傘可愛い。傘もよく見ると楽しいねえ。",
        en = "It’s still coming down… well, can’t do anything about it. Oh, that’s a cute umbrella. Looking at the umbrellas is pretty fun too.",
      },
    },
    ["Uranami"] = {
      {
        ja = "雨... 外出には傘が要りますが、少し落ち着いた気分になれて、雨の日もいいですよね。ほうじ茶でもいかですか?",
        en = "Rain ... I need an umbrella to go out, but I feel a little relaxed and rainy day is also good too. Would you like some green tea?",
      },
    },
    ["Mogami"] = {
      {
        ja = "三隈、どうしたの、元気ないね？わかった、鈴谷と熊野呼んで、お茶会でもしようか？ねっ。",
        en = "Mikuma, what's wrong, how are you? Okay, I'll called Suzuya and Kumano, then could we have a tea party? How is it?",
        note = "Secretary 1",
      },
    },
    ["Yamato"] = {
      {
        ja = "瑞雲…祭りですか、日向さん? はい、大和にも確かにそういった計画もあったのですが… え?それとは、違う?",
        en = "A Zuiun... Festival, Hyuuga-san? Yes, I'm sure I had plans for something like that too... Eh? That's something else?",
        line = "Secretary 2",
        note = "A reference to the Zuiun Festival, a KanColle event happening at Fuji-Q Highland starting June 17, 2017.",
      },
    },
    ["Warspite"] = {
      {
        ja = "Rainy Day… hmmm… Admiral… hmmm… なんでもないわ。雨の日は古傷が痛むの。不思議ね？",
        en = "Rainy Days… hmm… Admiral… hmm… no it’s nothing in particular. It’s just on rainy days I tend to feel down. Strange, isn’t it?",
      },
    },
    ["Gangut"] = {
      {
        ja = "また雨か？よく降るものだな？分かってる、「ツーユー」だろう。あいつらから聞いたさあ、「テーリーぼーず」を作るのだろう。任せておけ！",
        en = "It's still raining? It’s really coming down, isn’t it?　Oh, I know already, this is the so-called \"Tsuyu.\" Around this time, you guys all make “Teribozu”, don’t you? Leave it to me!",
      },
    },
    ["Kasuga Maru"] = {
      {
        ja = "梅雨、たまにはこんな時間もいいですね。でも、この子達は少しつまらなそう。提督、おでかけになるなら傘をお持ちください。",
        en = "The rainy season, I kind of think this time of year is pretty nice, but, these kids get a bit bored. Admiral please make sure to take an umbrella before you go out.",
        note = "\"Kids\" = Seaplanes.",
      },
    },
    ["Saratoga"] = {
      {
        ja = "これがうわさの「ツユ」ですね？確かに雨ばっかり。Eugene、それは？ええ、呪いの人形じゃ?？ああ、そうなんですね。私も挑戦してみます。。",
        en = "Is this the “Tsuyu” I’ve heard about? It certainly is rainy. What’s this thing for? Eh, is it a cursed doll? Oh, so that’s what it is, then. I want to try making one too!",
      },
    },
    ["Aquila"] = {
      {
        ja = "今日も雨、ニッポンの「ツユ」ね？　てるてるぼ、アクイラも作りたい。ああ、リベ！作りかった教えて！あれ？なんか違う...",
        en = "Raining today too, this is Japan’s “Tsuyu” right? Aquila wants to make a teru teru bo too! Ah, Libe! Teach me please! Huh? This is... different than I expected...",
      },
    },
    ["Kamoi"] = {
      {
        ja = "提督、おでかけになるから傘をお持ちください。この季節どうしても雨が多いですから。はい！",
        en = "Admiral, please make sure to take an umbrella before you go out. It will definitely rain a lot at this time of year. Yup!",
      },
    },
    ["Shimushu"] = {
      {
        ja = "クナ！今日も雨っす。て、あれ？なにしてるっす？なかなか器用っす。司令の縫いぐるみすか？あ？なんで睨んでるっす?違うっしゅ？",
        en = "Kuna! It’s raining again today too, su? Huh, hmmm? Whatcha' up to, su? You’re pretty skillful, su. Are you making that doll for the Commander, su? Huh? Why are you looking at me like that, su? Am I wrong?",
      },
    },
    ["Kunashiri"] = {
      {
        ja = "もう... なんか鬱陶しいこの季節！照る照る坊主作って吊るせば... 馬鹿、違う、違うから！じゃ自分で作って見なさいよ、ほら！",
        en = "Jeez… this is such an awful season! I wonder if we should make some teru teru bōzu… jerk, I didn’t mean that, that’s not what I meant! Fine, go make it yourself, go on!",
      },
    },
    ["Etorofu"] = {
      {
        ja = "雨... ですね... 司令、こんな時は照る照る坊主を作るといいみたい。ご一緒に作りませんか？手作りの照る照る坊主、ほら！可愛い！",
        en = "It’s raining, isn’t it… Commander, at times like this, I think it’d be good to make some teru teru bōzu. Do you want to make them with me? Hand made teru teru bōzu, look! It’s cute!",
      },
    },
  },
}