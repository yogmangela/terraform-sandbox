# Lorem Ipsum

You are given the following text:

> lorem ipsum dolor sit amet consectetur lorem ipsum et mihi quoniam et adipiscing elit.sed quoniam et advesperascit et mihi ad villam revertendum est nunc quidem hactenus ex rebus enim timiditas non ex vocabulis nascitur.nummus in croesi divitiis obscuratur pars est tamen divitiarum.nam quibus rebus efficiuntur voluptates eae non sunt in potestate sapientis.hoc mihi cum tuo fratre convenit.qui ita affectus beatum esse numquam probabis duo reges constructio interrete.de hominibus dici non necesse est.eam si varietatem diceres intellegerem ut etiam non dicente te intellego parvi enim primo ortu sic iacent tamquam omnino sine animo sint.ea possunt paria non esse.quamquam tu hanc copiosiorem etiam soles dicere.de quibus cupio scire quid sentias.universa enim illorum ratione cum tota vestra confligendum puto.ut nemo dubitet eorum omnia officia quo spectare quid sequi quid fugere debeant nunc vero a primo quidem mirabiliter occulta natura est nec perspici nec cognosci potest.videmusne ut pueri ne verberibus quidem a contemplandis rebus perquirendisque deterreantur sunt enim prima elementa naturae quibus auctis virtutis quasi germen efficitur.nam ut sint illa vendibiliora haec uberiora certe sunt.cur deinde metrodori liberos commendas.mihi inquam qui te id ipsum rogavi nam adhuc meo fortasse vitio quid ego quaeram non perspicis.quibus ego vehementer assentior.cur iustitia laudatur mihi enim satis est ipsis non satis.quid est enim aliud esse versutum nobis heracleotes ille dionysius flagitiose descivisse videtur a stoicis propter oculorum dolorem.diodorus eius auditor adiungit ad honestatem vacuitatem doloris.nos quidem virtutes sic natae sumus ut tibi serviremus aliud negotii nihil habemus.

## Facts/Definitions

* Everything is lowercase.
* There are only letters, full stops (`.`), and single whitespace characters.
* A word is defined as a sequence of letters delimited by either a whitespace or a full stop `.` character.
* A full stop character is not considered a word. A full stop is never preceded or followed by whitespace.
* Any two words are separated either by a single whitespace character (`dolor sit`), or by a full stop with no spaces (`elit.sed`)
* A sentence is defined as a sequence of words delimited by a full stop `.` character.

## Questions

Code answers to the following questions about the text above
1. How many words are there in the text?
2. How many sentences are there in the text?
3. What is the length of the longest word?
4. Which six words occur the most in the text?
5. What percentage of distinct words only occur once?
6. What is the average number of words per sentence?
7. Which three two-word phrases occur the most in the text?

## Bonus Question

What is the prominence of the five words that occur the most in the text? Prominence can be defined as the ratio of the position of a given word to the position of the other words in a text (the earlier in the text a word occurs, the more prominent it is).

Prominence can be calculated in the following way:

```
prominence = (totalWords - ((positionSum - 1) / positionsNum)) * (100 / totalWords)
```

where:

* `totalWords` = the total number of words in a text.
* `positionSum` = the sum of all positions of the word (e.g. if a word occurs on position 1 and 4 the sum of its positions is 5).
* `positionsNum` = the number of positions of the word.
* the first word in a text is at position 1.

### Examples

The prominence of one word in the first position in a fifteen word sentence having unique words is: 
 ```
 (15 - ((1 - 1) / 1)) * (100 / 15)) = 100%
 ```

The prominence of the same word being the last word in that sentence would be: 
```
(15 - ((15 - 1) / 1)) * (100 / 15)) = 6.67%
```

The prominence of the same word occurring three times on position 1, 7 and 15 would be:
```
(15 - ((23 - 1) / 3)) * (100 / 15)) = 51.11%
```

## Useful Notes

* You are free to copy paste the text above as a string in your preferred language, there is no need to read from a file in your code.
* The text has been cleaned up to allow for trivial parsing, we are not particularly interested in parsing techniques for now.
* At this stage, your solution is only required to work with the text above, do not worry about the general case. Strive to write clear and maintainable code, performance comes later.
