<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
            version="1.0"
            encoding="UTF-8"
            indent="yes"/>
<!-- doctype-public="-//Apertium//DTD dix V1.0//EN" -->
<!-- doctype-system="https://sourceforge.net/p/apertium/svn/HEAD/tree/trunk/lttoolbox/lttoolbox/dix.dtd" -->

<xsl:param name="r2l"/>

<xsl:key name="pos-lookup" match="pos-pair" use="blds"/>
<xsl:variable name="pos-table" select="document('pos-table.xml')/posdefs"/>

<xsl:template match="posdefs">
  <!-- for matching the root of pos-table.xml -->
  <xsl:param name="blds-pos"/>
  <xsl:choose>
    <xsl:when test="key('pos-lookup', $blds-pos)">
      <xsl:copy-of select="key('pos-lookup', $blds-pos)/apertium/s"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:element name="s">
        <xsl:attribute name="n">
          <xsl:value-of select="$blds-pos"/>
        </xsl:attribute>
      </xsl:element>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="Dictionary">
  <dictionary>
    <alphabet/>
    <sdefs>
      <sdef n="n" 	c="Noun"/>
      <sdef n="np" 	c="Proper noun"/>
      <sdef n="top"     c="Toponym"/>
      <sdef n="attr"    c="Attributive"/>
      <sdef n="prn" 	c="Pronoun"/>
      <sdef n="ref" 	c="Reflexive pronoun"/>
      <sdef n="res" 	c="Reciprocal pronoun"/>
      <sdef n="det" 	c="Determiner"/>
      <sdef n="pos" 	c="Possessive"/>
      <sdef n="p1" 	c="1st person"/>
      <sdef n="p2" 	c="2nd person"/>
      <sdef n="p3" 	c="3rd person"/>
      <sdef n="nt" 	c="Neuter"/>
      <sdef n="mf" 	c="Masculine / feminine, also utrum in nouns"/>
      <sdef n="mfn" 	c="Masculine / feminine / neuter"/>
      <sdef n="mn" 	c="Masculine / neuter"/>
      <sdef n="f" 	c="Feminine"/>
      <sdef n="m" 	c="Masculine"/>
      <sdef n="un" 	c="No gender"/>
      <sdef n="sp" 	c="Singular / plural"/>
      <sdef n="sg" 	c="Singular"/>
      <sdef n="du" 	c="Dual"/>
      <sdef n="pl" 	c="Plural"/>
      <sdef n="ind" 	c="Indefinite"/>
      <sdef n="def" 	c="Definite"/>
      <sdef n="nom" 	c="Nominative"/>
      <sdef n="acc" 	c="Accusative"/>
      <sdef n="gen" 	c="Genitive"/>
      <sdef n="dem" 	c="Demonstrative"/>
      <sdef n="itg" 	c="Question word / interrogative"/>
      <sdef n="qnt" 	c="Quantifier"/>
      <sdef n="neg" 	c="Negative"/>
      <sdef n="emph" 	c="Emphatic"/>
      <sdef n="vblex" 	c="Verb"/>
      <sdef n="pass" 	c="-st form"/>
      <sdef n="pstv" 	c="-st verb"/>
      <sdef n="inf" 	c="Infinitive"/>
      <sdef n="pres" 	c="Present"/>
      <sdef n="imp" 	c="Imperative"/>
      <sdef n="pret" 	c="Preterite"/>
      <sdef n="pp" 	c="Perfect participle (vblex/adj)"/>
      <sdef n="pprs" 	c="Present participle (adjectival)"/>
      <sdef n="pr" 	c="Preposition"/>
      <sdef n="adv" 	c="Adverb"/>
      <sdef n="ij" 	c="Interjection"/>
      <sdef n="adj" 	c="Adjective"/>
      <sdef n="sint" 	c="Synthetic (of adjectives)"/>
      <sdef n="part" 	c="Participle (infinitive)"/>
      <sdef n="sep" 	c="Seperable verb/particle"/>
      <sdef n="cnjsub" 	c="Subordinating conjunction"/>
      <sdef n="cnjcoo" 	c="Co-ordinating conjunction"/>
      <sdef n="cnjadv" 	c="Adverbial conjunction"/>
      <sdef n="posi" 	c="Positive"/>
      <sdef n="comp" 	c="Comparative"/>
      <sdef n="sup" 	c="Superlative"/>
      <sdef n="num" 	c="Numeral"/>
      <sdef n="ord" 	c="Ordinal"/>
      <sdef n="acr" 	c="Acronym"/>
      <sdef n="unc"     c="Uncountable"/>
      <sdef n="sent" 	c="Sentence end"/>
      <sdef n="cm" 	c="Comma"/>
      <sdef n="apos" 	c="Apostrophe"/>
      <sdef n="clb" 	c="Possible clause boundary"/>
      <sdef n="lpar" 	c="Left parenthesis"/>
      <sdef n="rpar" 	c="Right parenthesis"/>
      <sdef n="TODO" 	c="Unknown part-of-speech"/>
    </sdefs>

    <section id="main" type="standard">
      <xsl:apply-templates/>
    </section>
  </dictionary>
</xsl:template>

<!-- fall-through NestEntry -->
<xsl:template match="DictionaryEntry">
  <xsl:variable name="pos">
    <xsl:choose>
      <xsl:when test="HeadwordCtn/PartOfSpeech/@value">
        <xsl:apply-templates select="$pos-table">
          <xsl:with-param name="blds-pos" select="HeadwordCtn/PartOfSpeech/@value"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="HeadwordBlock/PartOfSpeech/@value">
        <xsl:apply-templates select="$pos-table">
          <xsl:with-param name="blds-pos" select="HeadwordBlock/PartOfSpeech/@value"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- Some not-yet-handled node structure: -->
      <xsl:otherwise><s n="TODO"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="headgender">
    <xsl:choose>
      <xsl:when test="HeadwordCtn/GrammaticalGender/@value">
        <xsl:apply-templates select="$pos-table">
          <xsl:with-param name="blds-pos" select="HeadwordCtn/GrammaticalGender/@value"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="HeadwordBlock/GrammaticalGender/@value">
        <xsl:apply-templates select="$pos-table">
          <xsl:with-param name="blds-pos" select="HeadwordBlock/GrammaticalGender/@value"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- Not set, no tag: -->
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="headword">
    <xsl:choose>
      <xsl:when test=".//HeadwordCtn/Headword/text()">
        <xsl:copy-of select=".//HeadwordCtn/Headword/text()"/>
      </xsl:when>
      <xsl:otherwise>TODO</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test=".//Translation">
      <xsl:apply-templates>
        <xsl:with-param name="pos">
          <xsl:copy-of select="$pos"/>
        </xsl:with-param>
        <xsl:with-param name="headgender">
          <xsl:copy-of select="$headgender"/>
        </xsl:with-param>
        <xsl:with-param name="headword">
          <xsl:copy-of select="$headword"/>
        </xsl:with-param>
      </xsl:apply-templates>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- skip these: -->
<xsl:template match="HeadwordCtn"/>
<xsl:template match="CompositionalPhraseCtn"/> <!-- would be nice, but no -->
<xsl:template match="SenseIndicator"/>
<xsl:template match="Definition"/>
<xsl:template match="DefinitionCtn"/>
<xsl:template match="ExampleCtn"/>
<xsl:template match="Note"/>
<xsl:template match="RangeOfApplication"/>
<xsl:template match="See"/>
<xsl:template match="SeeAlso"/>
<xsl:template match="Choice"/>
<xsl:template match="Example"/>
<xsl:template match="Antonym"/>
<xsl:template match="Inflection"/>
<xsl:template match="Display"/>
<xsl:template match="Pronunciation"/>

<xsl:template name="replace-space">
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text,' ')">
      <xsl:value-of select="substring-before($text,' ')"/>
      <b/>
      <xsl:call-template name="replace-space">
        <xsl:with-param name="text"
                        select="substring-after($text,' ')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="lt_e_helper">
  <xsl:param name="pos"/>
  <xsl:param name="lword"/>
  <xsl:param name="lgender"/>
  <xsl:param name="rword"/>
  <xsl:param name="rgender"/>
  <e>
    <p>
      <l>
        <xsl:call-template name="replace-space">
          <xsl:with-param name="text" select="normalize-space($lword)"/>
        </xsl:call-template>
        <xsl:copy-of select="$pos"/>
        <xsl:copy-of select="$lgender"/>
      </l>
      <r>
        <xsl:call-template name="replace-space">
          <xsl:with-param name="text" select="normalize-space($rword)"/>
        </xsl:call-template>
        <xsl:copy-of select="$pos"/>
        <xsl:copy-of select="$rgender"/>
      </r>
    </p>
  </e>
</xsl:template>

<xsl:template name="lt_e">
  <xsl:param name="pos"/>
  <xsl:param name="lword"/>
  <xsl:param name="lgender"/>
  <xsl:param name="rword"/>
  <xsl:param name="rgender"/>
  <xsl:choose>
    <xsl:when test="not($r2l=string('yes'))">
      <xsl:call-template name="lt_e_helper">
        <xsl:with-param name="pos"     select="$pos"/>
        <xsl:with-param name="lword"   select="$lword"/>
        <xsl:with-param name="lgender" select="$lgender"/>
        <xsl:with-param name="rword"   select="$rword"/>
        <xsl:with-param name="rgender" select="$rgender"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <!-- flip r and l here: -->
      <xsl:call-template name="lt_e_helper">
        <xsl:with-param name="pos"     select="$pos"/>
        <xsl:with-param name="lword"   select="$rword"/>
        <xsl:with-param name="lgender" select="$rgender"/>
        <xsl:with-param name="rword"   select="$lword"/>
        <xsl:with-param name="rgender" select="$lgender"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- fall-through TranslationBlock and TranslationCtn -->
<xsl:template match="Translation">
  <xsl:param name="pos"/>
  <xsl:param name="headgender"/>
  <xsl:param name="headword"/>
  <xsl:variable name="trgender">
    <xsl:choose>
      <xsl:when test="../GrammaticalGender/@value">
        <xsl:apply-templates select="$pos-table">
          <xsl:with-param name="blds-pos" select="../GrammaticalGender/@value"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- Not set, no tag: -->
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <!-- Skip translations of example sentences, or phrases not useful for MT -->
    <xsl:when test="ancestor::ExampleCtn or ancestor::CompositionalPhraseCtn">
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="lt_e">
        <xsl:with-param name="pos" select="$pos"/>
        <xsl:with-param name="lword" select="$headword"/>
        <xsl:with-param name="lgender" select="$headgender"/>
        <xsl:with-param name="rword" select="text()"/>
        <xsl:with-param name="rgender" select="$trgender"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- fall-through SenseGrp -->
<xsl:template match="Synonym">
  <xsl:param name="pos"/>
  <xsl:param name="headgender"/>
  <xsl:param name="headword"/> <!-- ignored (using text() instead) -->

  <xsl:choose>
    <xsl:when test="..//Translation">
      <xsl:apply-templates select="..//Translation">
        <xsl:with-param name="pos">
          <xsl:copy-of select="$pos"/>
        </xsl:with-param>
        <xsl:with-param name="headgender">
          <xsl:copy-of select="$headgender"/>
        </xsl:with-param>
        <xsl:with-param name="headword">
          <xsl:copy-of select="text()"/>
        </xsl:with-param>
      </xsl:apply-templates>
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
