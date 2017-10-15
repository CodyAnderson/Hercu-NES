<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="7.6.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="NES">
<packages>
<package name="36X2">
<wire x1="-48.26" y1="-5.08" x2="48.26" y2="-5.08" width="0.127" layer="25"/>
<wire x1="48.26" y1="-5.08" x2="48.26" y2="5.08" width="0.127" layer="25"/>
<wire x1="48.26" y1="5.08" x2="-48.26" y2="5.08" width="0.127" layer="25"/>
<wire x1="-48.26" y1="5.08" x2="-48.26" y2="-5.08" width="0.127" layer="25"/>
<wire x1="-46.99" y1="-1.27" x2="46.99" y2="-1.27" width="0.127" layer="25"/>
<wire x1="46.99" y1="-1.27" x2="46.99" y2="1.27" width="0.127" layer="25"/>
<wire x1="46.99" y1="1.27" x2="-46.99" y2="1.27" width="0.127" layer="25"/>
<wire x1="-46.99" y1="1.27" x2="-46.99" y2="-1.27" width="0.127" layer="25"/>
<text x="-47.625" y="3.175" size="1.27" layer="25">1</text>
<text x="46.355" y="3.175" size="1.27" layer="25">36</text>
<text x="-47.625" y="-4.445" size="1.27" layer="25">37</text>
<text x="46.355" y="-4.445" size="1.27" layer="25">72</text>
<pad name="P$1" x="-44.45" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$2" x="-41.91" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$3" x="-39.37" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$4" x="-36.83" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$5" x="-34.29" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$6" x="-31.75" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$7" x="-29.21" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$8" x="-26.67" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$9" x="-24.13" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$10" x="-21.59" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$11" x="-19.05" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$12" x="-16.51" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$13" x="-13.97" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$14" x="-11.43" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$15" x="-8.89" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$16" x="-6.35" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$17" x="-3.81" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$18" x="-1.27" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$19" x="1.27" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$20" x="3.81" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$21" x="6.35" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$22" x="8.89" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$23" x="11.43" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$24" x="13.97" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$25" x="16.51" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$26" x="19.05" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$27" x="21.59" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$28" x="24.13" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$29" x="26.67" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$30" x="29.21" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$31" x="31.75" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$32" x="34.29" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$33" x="36.83" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$34" x="39.37" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$35" x="41.91" y="2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$36" x="44.45" y="2.54" drill="0.8" shape="long" rot="R90"/>
<rectangle x1="-45.085" y1="1.27" x2="-43.815" y2="3.81" layer="16"/>
<rectangle x1="-45.085" y1="1.27" x2="-43.815" y2="3.81" layer="1"/>
<pad name="P$37" x="-44.45" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$38" x="-41.91" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$39" x="-39.37" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$40" x="-36.83" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$41" x="-34.29" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$42" x="-31.75" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$43" x="-29.21" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$44" x="-26.67" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$45" x="-24.13" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$46" x="-21.59" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$47" x="-19.05" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$48" x="-16.51" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$49" x="-13.97" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$50" x="-11.43" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$51" x="-8.89" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$52" x="-6.35" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$53" x="-3.81" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$54" x="-1.27" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$55" x="1.27" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$56" x="3.81" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$57" x="6.35" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$58" x="8.89" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$59" x="11.43" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$60" x="13.97" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$61" x="16.51" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$62" x="19.05" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$63" x="21.59" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$64" x="24.13" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$65" x="26.67" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$66" x="29.21" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$67" x="31.75" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$68" x="34.29" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$69" x="36.83" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$70" x="39.37" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$71" x="41.91" y="-2.54" drill="0.8" shape="long" rot="R90"/>
<pad name="P$72" x="44.45" y="-2.54" drill="0.8" shape="long" rot="R90"/>
</package>
<package name="40PINNER">
<pad name="P$1" x="-16.51" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$2" x="-16.51" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$3" x="-13.97" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$4" x="-13.97" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$5" x="-11.43" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$6" x="-11.43" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$7" x="-8.89" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$8" x="-8.89" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$9" x="-6.35" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$10" x="-6.35" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$11" x="-3.81" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$12" x="-3.81" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$13" x="-1.27" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$14" x="-1.27" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$15" x="1.27" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$16" x="1.27" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$17" x="3.81" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$18" x="3.81" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$19" x="6.35" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$20" x="6.35" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$21" x="8.89" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$22" x="8.89" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$23" x="11.43" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$24" x="11.43" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$25" x="13.97" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$26" x="13.97" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$27" x="16.51" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$28" x="16.51" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$29" x="19.05" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$30" x="19.05" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$31" x="21.59" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$32" x="21.59" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$33" x="24.13" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$34" x="24.13" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$35" x="26.67" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$36" x="26.67" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$37" x="29.21" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$38" x="29.21" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<pad name="P$39" x="31.75" y="-1.27" drill="0.8" shape="offset" rot="R270"/>
<pad name="P$40" x="31.75" y="1.27" drill="0.8" shape="offset" rot="R90"/>
<rectangle x1="-17.145" y1="-3.175" x2="-15.875" y2="-0.635" layer="16"/>
<rectangle x1="-17.145" y1="-3.175" x2="-15.875" y2="-0.635" layer="1"/>
<wire x1="-20.32" y1="-2.54" x2="35.56" y2="-2.54" width="0.127" layer="25"/>
<wire x1="35.56" y1="-2.54" x2="35.56" y2="2.54" width="0.127" layer="25"/>
<wire x1="35.56" y1="2.54" x2="-20.32" y2="2.54" width="0.127" layer="25"/>
<wire x1="-20.32" y1="2.54" x2="-20.32" y2="-2.54" width="0.127" layer="25"/>
<text x="-19.685" y="-1.905" size="1.27" layer="25">1</text>
<text x="-19.685" y="0.635" size="1.27" layer="25">2</text>
<text x="33.02" y="-1.905" size="1.27" layer="25">39</text>
<text x="33.02" y="0.635" size="1.27" layer="25">40</text>
</package>
</packages>
<symbols>
<symbol name="NES-CART-CONN">
<pin name="GND1" x="-10.16" y="0" length="middle"/>
<pin name="CPU_A11" x="-10.16" y="2.54" length="middle"/>
<pin name="CPU_A10" x="-10.16" y="5.08" length="middle"/>
<pin name="CPU_A9" x="-10.16" y="7.62" length="middle"/>
<pin name="CPU_A8" x="-10.16" y="10.16" length="middle"/>
<pin name="CPU_A7" x="-10.16" y="12.7" length="middle"/>
<pin name="CPU_A6" x="-10.16" y="15.24" length="middle"/>
<pin name="CPU_A5" x="-10.16" y="17.78" length="middle"/>
<pin name="CPU_A4" x="-10.16" y="20.32" length="middle"/>
<pin name="CPU_A3" x="-10.16" y="22.86" length="middle"/>
<pin name="CPU_A2" x="-10.16" y="25.4" length="middle"/>
<pin name="CPU_A1" x="-10.16" y="27.94" length="middle"/>
<pin name="CPU_A0" x="-10.16" y="30.48" length="middle"/>
<pin name="CPU_R/W" x="-10.16" y="33.02" length="middle"/>
<pin name="/IRQ" x="-10.16" y="35.56" length="middle"/>
<pin name="EXP_0" x="-10.16" y="38.1" length="middle"/>
<pin name="EXP_1" x="-10.16" y="40.64" length="middle"/>
<pin name="EXP_2" x="-10.16" y="43.18" length="middle"/>
<pin name="EXP_3" x="-10.16" y="45.72" length="middle"/>
<pin name="EXP_4" x="-10.16" y="48.26" length="middle"/>
<pin name="PPU_/RD" x="-10.16" y="50.8" length="middle"/>
<pin name="CIRAM_A10" x="-10.16" y="53.34" length="middle"/>
<pin name="PPU_A6" x="-10.16" y="55.88" length="middle"/>
<pin name="PPU_A5" x="-10.16" y="58.42" length="middle"/>
<pin name="PPU_A4" x="-10.16" y="60.96" length="middle"/>
<pin name="PPU_A3" x="-10.16" y="63.5" length="middle"/>
<pin name="PPU_A2" x="-10.16" y="66.04" length="middle"/>
<pin name="PPU_A1" x="-10.16" y="68.58" length="middle"/>
<pin name="PPU_A0" x="-10.16" y="71.12" length="middle"/>
<pin name="PPU_D0" x="-10.16" y="73.66" length="middle"/>
<pin name="PPU_D1" x="-10.16" y="76.2" length="middle"/>
<pin name="PPU_D2" x="-10.16" y="78.74" length="middle"/>
<pin name="PPU_D3" x="-10.16" y="81.28" length="middle"/>
<pin name="CICTOPAK" x="-10.16" y="83.82" length="middle"/>
<pin name="CICTOMB" x="-10.16" y="86.36" length="middle"/>
<pin name="+5V" x="-10.16" y="88.9" length="middle"/>
<pin name="GND2" x="25.4" y="88.9" length="middle" rot="R180"/>
<pin name="CIC_CLK" x="25.4" y="86.36" length="middle" rot="R180"/>
<pin name="CIC_/RST" x="25.4" y="83.82" length="middle" rot="R180"/>
<pin name="PPU_D4" x="25.4" y="81.28" length="middle" rot="R180"/>
<pin name="PPU_D5" x="25.4" y="78.74" length="middle" rot="R180"/>
<pin name="PPU_D6" x="25.4" y="76.2" length="middle" rot="R180"/>
<pin name="PPU_D7" x="25.4" y="73.66" length="middle" rot="R180"/>
<pin name="PPU_A13" x="25.4" y="71.12" length="middle" rot="R180"/>
<pin name="PPU_A12" x="25.4" y="68.58" length="middle" rot="R180"/>
<pin name="PPU_A10" x="25.4" y="66.04" length="middle" rot="R180"/>
<pin name="PPU_A11" x="25.4" y="63.5" length="middle" rot="R180"/>
<pin name="PPU_A9" x="25.4" y="60.96" length="middle" rot="R180"/>
<pin name="PPU_A8" x="25.4" y="58.42" length="middle" rot="R180"/>
<pin name="PPU_A7" x="25.4" y="55.88" length="middle" rot="R180"/>
<pin name="PPU_/A13" x="25.4" y="53.34" length="middle" rot="R180"/>
<pin name="CIRAM_/CE" x="25.4" y="50.8" length="middle" rot="R180"/>
<pin name="PPU_/WR" x="25.4" y="48.26" length="middle" rot="R180"/>
<pin name="EXP_5" x="25.4" y="45.72" length="middle" rot="R180"/>
<pin name="EXP_6" x="25.4" y="43.18" length="middle" rot="R180"/>
<pin name="EXP_7" x="25.4" y="40.64" length="middle" rot="R180"/>
<pin name="EXP_8" x="25.4" y="38.1" length="middle" rot="R180"/>
<pin name="EXP_9" x="25.4" y="35.56" length="middle" rot="R180"/>
<pin name="/ROMSEL" x="25.4" y="33.02" length="middle" rot="R180"/>
<pin name="CPU_D0" x="25.4" y="30.48" length="middle" rot="R180"/>
<pin name="CPU_D1" x="25.4" y="27.94" length="middle" rot="R180"/>
<pin name="CPU_D2" x="25.4" y="25.4" length="middle" rot="R180"/>
<pin name="CPU_D3" x="25.4" y="22.86" length="middle" rot="R180"/>
<pin name="CPU_D4" x="25.4" y="20.32" length="middle" rot="R180"/>
<pin name="CPU_D5" x="25.4" y="17.78" length="middle" rot="R180"/>
<pin name="CPU_D6" x="25.4" y="15.24" length="middle" rot="R180"/>
<pin name="CPU_D7" x="25.4" y="12.7" length="middle" rot="R180"/>
<pin name="CPU_A14" x="25.4" y="10.16" length="middle" rot="R180"/>
<pin name="CPU_A13" x="25.4" y="7.62" length="middle" rot="R180"/>
<pin name="CPU_A12" x="25.4" y="5.08" length="middle" rot="R180"/>
<pin name="M2" x="25.4" y="2.54" length="middle" rot="R180"/>
<pin name="SYSTEM_CLK" x="25.4" y="0" length="middle" rot="R180"/>
<wire x1="-5.08" y1="91.44" x2="20.32" y2="91.44" width="0.254" layer="94"/>
<wire x1="20.32" y1="91.44" x2="20.32" y2="-2.54" width="0.254" layer="94"/>
<wire x1="20.32" y1="-2.54" x2="-5.08" y2="-2.54" width="0.254" layer="94"/>
<wire x1="-5.08" y1="-2.54" x2="-5.08" y2="91.44" width="0.254" layer="94"/>
</symbol>
<symbol name="40PINNER">
<wire x1="-7.62" y1="-25.4" x2="7.62" y2="-25.4" width="0.254" layer="94"/>
<wire x1="7.62" y1="-25.4" x2="7.62" y2="27.94" width="0.254" layer="94"/>
<wire x1="7.62" y1="27.94" x2="-7.62" y2="27.94" width="0.254" layer="94"/>
<wire x1="-7.62" y1="27.94" x2="-7.62" y2="-25.4" width="0.254" layer="94"/>
<pin name="P$1" x="-12.7" y="25.4" length="middle"/>
<pin name="P$2" x="12.7" y="25.4" length="middle" rot="R180"/>
<pin name="P$3" x="-12.7" y="22.86" length="middle"/>
<pin name="P$4" x="12.7" y="22.86" length="middle" rot="R180"/>
<pin name="P$5" x="-12.7" y="20.32" length="middle"/>
<pin name="P$6" x="12.7" y="20.32" length="middle" rot="R180"/>
<pin name="P$7" x="-12.7" y="17.78" length="middle"/>
<pin name="P$8" x="12.7" y="17.78" length="middle" rot="R180"/>
<pin name="P$9" x="-12.7" y="15.24" length="middle"/>
<pin name="P$10" x="12.7" y="15.24" length="middle" rot="R180"/>
<pin name="P$11" x="-12.7" y="12.7" length="middle"/>
<pin name="P$12" x="12.7" y="12.7" length="middle" rot="R180"/>
<pin name="P$13" x="-12.7" y="10.16" length="middle"/>
<pin name="P$14" x="12.7" y="10.16" length="middle" rot="R180"/>
<pin name="P$15" x="-12.7" y="7.62" length="middle"/>
<pin name="P$16" x="12.7" y="7.62" length="middle" rot="R180"/>
<pin name="P$17" x="-12.7" y="5.08" length="middle"/>
<pin name="P$18" x="12.7" y="5.08" length="middle" rot="R180"/>
<pin name="P$19" x="-12.7" y="2.54" length="middle"/>
<pin name="P$20" x="12.7" y="2.54" length="middle" rot="R180"/>
<pin name="P$21" x="-12.7" y="0" length="middle"/>
<pin name="P$22" x="12.7" y="0" length="middle" rot="R180"/>
<pin name="P$23" x="-12.7" y="-2.54" length="middle"/>
<pin name="P$24" x="12.7" y="-2.54" length="middle" rot="R180"/>
<pin name="P$25" x="-12.7" y="-5.08" length="middle"/>
<pin name="P$26" x="12.7" y="-5.08" length="middle" rot="R180"/>
<pin name="P$27" x="-12.7" y="-7.62" length="middle"/>
<pin name="P$28" x="12.7" y="-7.62" length="middle" rot="R180"/>
<pin name="P$29" x="-12.7" y="-10.16" length="middle"/>
<pin name="P$30" x="12.7" y="-10.16" length="middle" rot="R180"/>
<pin name="P$31" x="-12.7" y="-12.7" length="middle"/>
<pin name="P$32" x="12.7" y="-12.7" length="middle" rot="R180"/>
<pin name="P$33" x="-12.7" y="-15.24" length="middle"/>
<pin name="P$34" x="12.7" y="-15.24" length="middle" rot="R180"/>
<pin name="P$35" x="-12.7" y="-17.78" length="middle"/>
<pin name="P$36" x="12.7" y="-17.78" length="middle" rot="R180"/>
<pin name="P$37" x="-12.7" y="-20.32" length="middle"/>
<pin name="P$38" x="12.7" y="-20.32" length="middle" rot="R180"/>
<pin name="P$39" x="-12.7" y="-22.86" length="middle"/>
<pin name="P$40" x="12.7" y="-22.86" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="NES_CONN">
<description>NES</description>
<gates>
<gate name="G$1" symbol="NES-CART-CONN" x="-7.62" y="-45.72"/>
</gates>
<devices>
<device name="" package="36X2">
<connects>
<connect gate="G$1" pin="+5V" pad="P$36"/>
<connect gate="G$1" pin="/IRQ" pad="P$15"/>
<connect gate="G$1" pin="/ROMSEL" pad="P$50"/>
<connect gate="G$1" pin="CICTOMB" pad="P$35"/>
<connect gate="G$1" pin="CICTOPAK" pad="P$34"/>
<connect gate="G$1" pin="CIC_/RST" pad="P$70"/>
<connect gate="G$1" pin="CIC_CLK" pad="P$71"/>
<connect gate="G$1" pin="CIRAM_/CE" pad="P$57"/>
<connect gate="G$1" pin="CIRAM_A10" pad="P$22"/>
<connect gate="G$1" pin="CPU_A0" pad="P$13"/>
<connect gate="G$1" pin="CPU_A1" pad="P$12"/>
<connect gate="G$1" pin="CPU_A10" pad="P$3"/>
<connect gate="G$1" pin="CPU_A11" pad="P$2"/>
<connect gate="G$1" pin="CPU_A12" pad="P$39"/>
<connect gate="G$1" pin="CPU_A13" pad="P$40"/>
<connect gate="G$1" pin="CPU_A14" pad="P$41"/>
<connect gate="G$1" pin="CPU_A2" pad="P$11"/>
<connect gate="G$1" pin="CPU_A3" pad="P$10"/>
<connect gate="G$1" pin="CPU_A4" pad="P$9"/>
<connect gate="G$1" pin="CPU_A5" pad="P$8"/>
<connect gate="G$1" pin="CPU_A6" pad="P$7"/>
<connect gate="G$1" pin="CPU_A7" pad="P$6"/>
<connect gate="G$1" pin="CPU_A8" pad="P$5"/>
<connect gate="G$1" pin="CPU_A9" pad="P$4"/>
<connect gate="G$1" pin="CPU_D0" pad="P$49"/>
<connect gate="G$1" pin="CPU_D1" pad="P$48"/>
<connect gate="G$1" pin="CPU_D2" pad="P$47"/>
<connect gate="G$1" pin="CPU_D3" pad="P$46"/>
<connect gate="G$1" pin="CPU_D4" pad="P$45"/>
<connect gate="G$1" pin="CPU_D5" pad="P$44"/>
<connect gate="G$1" pin="CPU_D6" pad="P$43"/>
<connect gate="G$1" pin="CPU_D7" pad="P$42"/>
<connect gate="G$1" pin="CPU_R/W" pad="P$14"/>
<connect gate="G$1" pin="EXP_0" pad="P$16"/>
<connect gate="G$1" pin="EXP_1" pad="P$17"/>
<connect gate="G$1" pin="EXP_2" pad="P$18"/>
<connect gate="G$1" pin="EXP_3" pad="P$19"/>
<connect gate="G$1" pin="EXP_4" pad="P$20"/>
<connect gate="G$1" pin="EXP_5" pad="P$55"/>
<connect gate="G$1" pin="EXP_6" pad="P$54"/>
<connect gate="G$1" pin="EXP_7" pad="P$53"/>
<connect gate="G$1" pin="EXP_8" pad="P$52"/>
<connect gate="G$1" pin="EXP_9" pad="P$51"/>
<connect gate="G$1" pin="GND1" pad="P$1"/>
<connect gate="G$1" pin="GND2" pad="P$72"/>
<connect gate="G$1" pin="M2" pad="P$38"/>
<connect gate="G$1" pin="PPU_/A13" pad="P$58"/>
<connect gate="G$1" pin="PPU_/RD" pad="P$21"/>
<connect gate="G$1" pin="PPU_/WR" pad="P$56"/>
<connect gate="G$1" pin="PPU_A0" pad="P$29"/>
<connect gate="G$1" pin="PPU_A1" pad="P$28"/>
<connect gate="G$1" pin="PPU_A10" pad="P$63"/>
<connect gate="G$1" pin="PPU_A11" pad="P$62"/>
<connect gate="G$1" pin="PPU_A12" pad="P$64"/>
<connect gate="G$1" pin="PPU_A13" pad="P$65"/>
<connect gate="G$1" pin="PPU_A2" pad="P$27"/>
<connect gate="G$1" pin="PPU_A3" pad="P$26"/>
<connect gate="G$1" pin="PPU_A4" pad="P$25"/>
<connect gate="G$1" pin="PPU_A5" pad="P$24"/>
<connect gate="G$1" pin="PPU_A6" pad="P$23"/>
<connect gate="G$1" pin="PPU_A7" pad="P$59"/>
<connect gate="G$1" pin="PPU_A8" pad="P$60"/>
<connect gate="G$1" pin="PPU_A9" pad="P$61"/>
<connect gate="G$1" pin="PPU_D0" pad="P$30"/>
<connect gate="G$1" pin="PPU_D1" pad="P$31"/>
<connect gate="G$1" pin="PPU_D2" pad="P$32"/>
<connect gate="G$1" pin="PPU_D3" pad="P$33"/>
<connect gate="G$1" pin="PPU_D4" pad="P$69"/>
<connect gate="G$1" pin="PPU_D5" pad="P$68"/>
<connect gate="G$1" pin="PPU_D6" pad="P$67"/>
<connect gate="G$1" pin="PPU_D7" pad="P$66"/>
<connect gate="G$1" pin="SYSTEM_CLK" pad="P$37"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="40PINNER">
<gates>
<gate name="G$1" symbol="40PINNER" x="0" y="0"/>
</gates>
<devices>
<device name="" package="40PINNER">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
<connect gate="G$1" pin="P$10" pad="P$10"/>
<connect gate="G$1" pin="P$11" pad="P$11"/>
<connect gate="G$1" pin="P$12" pad="P$12"/>
<connect gate="G$1" pin="P$13" pad="P$13"/>
<connect gate="G$1" pin="P$14" pad="P$14"/>
<connect gate="G$1" pin="P$15" pad="P$15"/>
<connect gate="G$1" pin="P$16" pad="P$16"/>
<connect gate="G$1" pin="P$17" pad="P$17"/>
<connect gate="G$1" pin="P$18" pad="P$18"/>
<connect gate="G$1" pin="P$19" pad="P$19"/>
<connect gate="G$1" pin="P$2" pad="P$2"/>
<connect gate="G$1" pin="P$20" pad="P$20"/>
<connect gate="G$1" pin="P$21" pad="P$21"/>
<connect gate="G$1" pin="P$22" pad="P$22"/>
<connect gate="G$1" pin="P$23" pad="P$23"/>
<connect gate="G$1" pin="P$24" pad="P$24"/>
<connect gate="G$1" pin="P$25" pad="P$25"/>
<connect gate="G$1" pin="P$26" pad="P$26"/>
<connect gate="G$1" pin="P$27" pad="P$27"/>
<connect gate="G$1" pin="P$28" pad="P$28"/>
<connect gate="G$1" pin="P$29" pad="P$29"/>
<connect gate="G$1" pin="P$3" pad="P$3"/>
<connect gate="G$1" pin="P$30" pad="P$30"/>
<connect gate="G$1" pin="P$31" pad="P$31"/>
<connect gate="G$1" pin="P$32" pad="P$32"/>
<connect gate="G$1" pin="P$33" pad="P$33"/>
<connect gate="G$1" pin="P$34" pad="P$34"/>
<connect gate="G$1" pin="P$35" pad="P$35"/>
<connect gate="G$1" pin="P$36" pad="P$36"/>
<connect gate="G$1" pin="P$37" pad="P$37"/>
<connect gate="G$1" pin="P$38" pad="P$38"/>
<connect gate="G$1" pin="P$39" pad="P$39"/>
<connect gate="G$1" pin="P$4" pad="P$4"/>
<connect gate="G$1" pin="P$40" pad="P$40"/>
<connect gate="G$1" pin="P$5" pad="P$5"/>
<connect gate="G$1" pin="P$6" pad="P$6"/>
<connect gate="G$1" pin="P$7" pad="P$7"/>
<connect gate="G$1" pin="P$8" pad="P$8"/>
<connect gate="G$1" pin="P$9" pad="P$9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="U$1" library="NES" deviceset="NES_CONN" device=""/>
<part name="U$2" library="NES" deviceset="40PINNER" device=""/>
<part name="U$3" library="NES" deviceset="40PINNER" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="U$1" gate="G$1" x="142.24" y="43.18" rot="R90"/>
<instance part="U$2" gate="G$1" x="63.5" y="127" rot="R90"/>
<instance part="U$3" gate="G$1" x="121.92" y="127" rot="R270"/>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="GND1"/>
<wire x1="142.24" y1="33.02" x2="154.94" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$12"/>
<pinref part="U$3" gate="G$1" pin="P$12"/>
<wire x1="154.94" y1="53.34" x2="154.94" y2="33.02" width="0.1524" layer="91"/>
<wire x1="154.94" y1="124.46" x2="154.94" y2="53.34" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="GND2"/>
<wire x1="134.62" y1="114.3" x2="134.62" y2="124.46" width="0.1524" layer="91"/>
<wire x1="134.62" y1="124.46" x2="154.94" y2="124.46" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$30"/>
<wire x1="111.76" y1="114.3" x2="111.76" y2="124.46" width="0.1524" layer="91"/>
<wire x1="111.76" y1="124.46" x2="134.62" y2="124.46" width="0.1524" layer="91"/>
<junction x="134.62" y="124.46"/>
<wire x1="73.66" y1="124.46" x2="111.76" y2="124.46" width="0.1524" layer="91"/>
<junction x="111.76" y="124.46"/>
<wire x1="53.34" y1="68.58" x2="53.34" y2="53.34" width="0.1524" layer="91"/>
<wire x1="53.34" y1="53.34" x2="154.94" y2="53.34" width="0.1524" layer="91"/>
<junction x="154.94" y="53.34"/>
<pinref part="U$2" gate="G$1" pin="P$30"/>
<wire x1="73.66" y1="139.7" x2="73.66" y2="124.46" width="0.1524" layer="91"/>
<junction x="73.66" y="124.46"/>
<wire x1="50.8" y1="139.7" x2="50.8" y2="132.08" width="0.1524" layer="91"/>
<wire x1="50.8" y1="132.08" x2="58.42" y2="132.08" width="0.1524" layer="91"/>
<wire x1="58.42" y1="132.08" x2="58.42" y2="124.46" width="0.1524" layer="91"/>
<wire x1="58.42" y1="124.46" x2="73.66" y2="124.46" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A11"/>
<wire x1="139.7" y1="33.02" x2="139.7" y2="30.48" width="0.1524" layer="91"/>
<wire x1="139.7" y1="30.48" x2="157.48" y2="30.48" width="0.1524" layer="91"/>
<wire x1="157.48" y1="30.48" x2="157.48" y2="142.24" width="0.1524" layer="91"/>
<wire x1="157.48" y1="142.24" x2="137.16" y2="142.24" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$9"/>
<wire x1="137.16" y1="142.24" x2="137.16" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A10"/>
<wire x1="137.16" y1="33.02" x2="137.16" y2="27.94" width="0.1524" layer="91"/>
<wire x1="137.16" y1="27.94" x2="160.02" y2="27.94" width="0.1524" layer="91"/>
<wire x1="160.02" y1="27.94" x2="160.02" y2="144.78" width="0.1524" layer="91"/>
<wire x1="160.02" y1="144.78" x2="132.08" y2="144.78" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$13"/>
<wire x1="132.08" y1="144.78" x2="132.08" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A9"/>
<wire x1="134.62" y1="33.02" x2="134.62" y2="25.4" width="0.1524" layer="91"/>
<wire x1="134.62" y1="25.4" x2="162.56" y2="25.4" width="0.1524" layer="91"/>
<wire x1="162.56" y1="25.4" x2="162.56" y2="147.32" width="0.1524" layer="91"/>
<wire x1="162.56" y1="147.32" x2="129.54" y2="147.32" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$15"/>
<wire x1="129.54" y1="147.32" x2="129.54" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A8"/>
<wire x1="132.08" y1="33.02" x2="132.08" y2="22.86" width="0.1524" layer="91"/>
<wire x1="132.08" y1="22.86" x2="165.1" y2="22.86" width="0.1524" layer="91"/>
<wire x1="165.1" y1="22.86" x2="165.1" y2="149.86" width="0.1524" layer="91"/>
<wire x1="165.1" y1="149.86" x2="127" y2="149.86" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$17"/>
<wire x1="127" y1="149.86" x2="127" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A7"/>
<wire x1="129.54" y1="33.02" x2="129.54" y2="20.32" width="0.1524" layer="91"/>
<wire x1="129.54" y1="20.32" x2="167.64" y2="20.32" width="0.1524" layer="91"/>
<wire x1="167.64" y1="20.32" x2="167.64" y2="152.4" width="0.1524" layer="91"/>
<wire x1="167.64" y1="152.4" x2="124.46" y2="152.4" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$19"/>
<wire x1="124.46" y1="152.4" x2="124.46" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$11"/>
<pinref part="U$1" gate="G$1" pin="+5V"/>
<pinref part="U$3" gate="G$1" pin="P$11"/>
<wire x1="50.8" y1="129.54" x2="134.62" y2="129.54" width="0.1524" layer="91"/>
<wire x1="134.62" y1="129.54" x2="134.62" y2="139.7" width="0.1524" layer="91"/>
<wire x1="50.8" y1="114.3" x2="50.8" y2="129.54" width="0.1524" layer="91"/>
<wire x1="50.8" y1="129.54" x2="-83.82" y2="129.54" width="0.1524" layer="91"/>
<wire x1="-83.82" y1="129.54" x2="-83.82" y2="33.02" width="0.1524" layer="91"/>
<junction x="50.8" y="129.54"/>
<wire x1="-83.82" y1="33.02" x2="53.34" y2="33.02" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$23" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A6"/>
<wire x1="127" y1="33.02" x2="127" y2="17.78" width="0.1524" layer="91"/>
<wire x1="127" y1="17.78" x2="170.18" y2="17.78" width="0.1524" layer="91"/>
<wire x1="170.18" y1="17.78" x2="170.18" y2="154.94" width="0.1524" layer="91"/>
<wire x1="170.18" y1="154.94" x2="121.92" y2="154.94" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$21"/>
<wire x1="121.92" y1="154.94" x2="121.92" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$24" class="0">
<segment>
<wire x1="119.38" y1="157.48" x2="172.72" y2="157.48" width="0.1524" layer="91"/>
<wire x1="172.72" y1="157.48" x2="172.72" y2="15.24" width="0.1524" layer="91"/>
<wire x1="172.72" y1="15.24" x2="124.46" y2="15.24" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CPU_A5"/>
<wire x1="124.46" y1="15.24" x2="124.46" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$23"/>
<wire x1="119.38" y1="157.48" x2="119.38" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$25" class="0">
<segment>
<wire x1="116.84" y1="160.02" x2="175.26" y2="160.02" width="0.1524" layer="91"/>
<wire x1="175.26" y1="160.02" x2="175.26" y2="12.7" width="0.1524" layer="91"/>
<wire x1="175.26" y1="12.7" x2="121.92" y2="12.7" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CPU_A4"/>
<wire x1="121.92" y1="12.7" x2="121.92" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$25"/>
<wire x1="116.84" y1="160.02" x2="116.84" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$26" class="0">
<segment>
<wire x1="114.3" y1="162.56" x2="177.8" y2="162.56" width="0.1524" layer="91"/>
<wire x1="177.8" y1="162.56" x2="177.8" y2="10.16" width="0.1524" layer="91"/>
<wire x1="177.8" y1="10.16" x2="119.38" y2="10.16" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CPU_A3"/>
<wire x1="119.38" y1="10.16" x2="119.38" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$27"/>
<wire x1="114.3" y1="162.56" x2="114.3" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$27" class="0">
<segment>
<wire x1="109.22" y1="165.1" x2="180.34" y2="165.1" width="0.1524" layer="91"/>
<wire x1="180.34" y1="165.1" x2="180.34" y2="7.62" width="0.1524" layer="91"/>
<wire x1="180.34" y1="7.62" x2="116.84" y2="7.62" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CPU_A2"/>
<wire x1="116.84" y1="7.62" x2="116.84" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$31"/>
<wire x1="109.22" y1="165.1" x2="109.22" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$28" class="0">
<segment>
<wire x1="106.68" y1="167.64" x2="182.88" y2="167.64" width="0.1524" layer="91"/>
<wire x1="182.88" y1="167.64" x2="182.88" y2="5.08" width="0.1524" layer="91"/>
<wire x1="182.88" y1="5.08" x2="114.3" y2="5.08" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CPU_A1"/>
<wire x1="114.3" y1="5.08" x2="114.3" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$33"/>
<wire x1="106.68" y1="167.64" x2="106.68" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$29" class="0">
<segment>
<wire x1="104.14" y1="170.18" x2="185.42" y2="170.18" width="0.1524" layer="91"/>
<wire x1="185.42" y1="170.18" x2="185.42" y2="2.54" width="0.1524" layer="91"/>
<wire x1="185.42" y1="2.54" x2="111.76" y2="2.54" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CPU_A0"/>
<wire x1="111.76" y1="2.54" x2="111.76" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$35"/>
<wire x1="104.14" y1="170.18" x2="104.14" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$30" class="0">
<segment>
<wire x1="101.6" y1="172.72" x2="187.96" y2="172.72" width="0.1524" layer="91"/>
<wire x1="187.96" y1="172.72" x2="187.96" y2="0" width="0.1524" layer="91"/>
<wire x1="187.96" y1="0" x2="109.22" y2="0" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="CPU_R/W"/>
<wire x1="109.22" y1="0" x2="109.22" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$37"/>
<wire x1="101.6" y1="172.72" x2="101.6" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$31" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="/IRQ"/>
<wire x1="106.68" y1="33.02" x2="106.68" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="106.68" y1="-2.54" x2="190.5" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="190.5" y1="-2.54" x2="190.5" y2="175.26" width="0.1524" layer="91"/>
<wire x1="190.5" y1="175.26" x2="99.06" y2="175.26" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$39"/>
<wire x1="99.06" y1="175.26" x2="99.06" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$33" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_D4"/>
<wire x1="60.96" y1="76.2" x2="60.96" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$9"/>
<wire x1="60.96" y1="76.2" x2="48.26" y2="76.2" width="0.1524" layer="91"/>
<wire x1="48.26" y1="76.2" x2="48.26" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$34" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_D5"/>
<wire x1="63.5" y1="78.74" x2="63.5" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$13"/>
<wire x1="63.5" y1="78.74" x2="53.34" y2="78.74" width="0.1524" layer="91"/>
<wire x1="53.34" y1="78.74" x2="53.34" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$35" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_D6"/>
<wire x1="66.04" y1="81.28" x2="66.04" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$15"/>
<wire x1="66.04" y1="81.28" x2="55.88" y2="81.28" width="0.1524" layer="91"/>
<wire x1="55.88" y1="81.28" x2="55.88" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$36" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_D7"/>
<wire x1="68.58" y1="83.82" x2="68.58" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$17"/>
<wire x1="68.58" y1="83.82" x2="58.42" y2="83.82" width="0.1524" layer="91"/>
<wire x1="58.42" y1="83.82" x2="58.42" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$37" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A13"/>
<wire x1="71.12" y1="86.36" x2="71.12" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$19"/>
<wire x1="71.12" y1="86.36" x2="60.96" y2="86.36" width="0.1524" layer="91"/>
<wire x1="60.96" y1="86.36" x2="60.96" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$38" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A12"/>
<wire x1="73.66" y1="88.9" x2="73.66" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$21"/>
<wire x1="73.66" y1="88.9" x2="63.5" y2="88.9" width="0.1524" layer="91"/>
<wire x1="63.5" y1="88.9" x2="63.5" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$39" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A10"/>
<wire x1="76.2" y1="91.44" x2="76.2" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$23"/>
<wire x1="76.2" y1="91.44" x2="66.04" y2="91.44" width="0.1524" layer="91"/>
<wire x1="66.04" y1="91.44" x2="66.04" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$40" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A11"/>
<wire x1="78.74" y1="93.98" x2="78.74" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$25"/>
<wire x1="78.74" y1="93.98" x2="68.58" y2="93.98" width="0.1524" layer="91"/>
<wire x1="68.58" y1="93.98" x2="68.58" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$41" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A9"/>
<wire x1="81.28" y1="96.52" x2="81.28" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$27"/>
<wire x1="81.28" y1="96.52" x2="71.12" y2="96.52" width="0.1524" layer="91"/>
<wire x1="71.12" y1="96.52" x2="71.12" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$42" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A8"/>
<wire x1="83.82" y1="99.06" x2="83.82" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$31"/>
<wire x1="83.82" y1="99.06" x2="76.2" y2="99.06" width="0.1524" layer="91"/>
<wire x1="76.2" y1="99.06" x2="76.2" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$43" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A7"/>
<wire x1="86.36" y1="101.6" x2="86.36" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$33"/>
<wire x1="86.36" y1="101.6" x2="78.74" y2="101.6" width="0.1524" layer="91"/>
<wire x1="78.74" y1="101.6" x2="78.74" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$44" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_/A13"/>
<wire x1="88.9" y1="104.14" x2="88.9" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$35"/>
<wire x1="88.9" y1="104.14" x2="81.28" y2="104.14" width="0.1524" layer="91"/>
<wire x1="81.28" y1="104.14" x2="81.28" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$45" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CIRAM_/CE"/>
<wire x1="91.44" y1="106.68" x2="91.44" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$37"/>
<wire x1="91.44" y1="106.68" x2="83.82" y2="106.68" width="0.1524" layer="91"/>
<wire x1="83.82" y1="106.68" x2="83.82" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$46" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_/WR"/>
<wire x1="93.98" y1="109.22" x2="93.98" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$39"/>
<wire x1="93.98" y1="109.22" x2="86.36" y2="109.22" width="0.1524" layer="91"/>
<wire x1="86.36" y1="109.22" x2="86.36" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$49" class="0">
<segment>
<wire x1="48.26" y1="147.32" x2="27.94" y2="147.32" width="0.1524" layer="91"/>
<wire x1="27.94" y1="147.32" x2="27.94" y2="25.4" width="0.1524" layer="91"/>
<wire x1="27.94" y1="25.4" x2="60.96" y2="25.4" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_D3"/>
<wire x1="60.96" y1="25.4" x2="60.96" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$10"/>
<wire x1="48.26" y1="147.32" x2="48.26" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$50" class="0">
<segment>
<wire x1="53.34" y1="149.86" x2="25.4" y2="149.86" width="0.1524" layer="91"/>
<wire x1="25.4" y1="149.86" x2="25.4" y2="22.86" width="0.1524" layer="91"/>
<wire x1="25.4" y1="22.86" x2="63.5" y2="22.86" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_D2"/>
<wire x1="63.5" y1="22.86" x2="63.5" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$14"/>
<wire x1="53.34" y1="149.86" x2="53.34" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$51" class="0">
<segment>
<wire x1="55.88" y1="152.4" x2="22.86" y2="152.4" width="0.1524" layer="91"/>
<wire x1="22.86" y1="152.4" x2="22.86" y2="20.32" width="0.1524" layer="91"/>
<wire x1="22.86" y1="20.32" x2="66.04" y2="20.32" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_D1"/>
<wire x1="66.04" y1="20.32" x2="66.04" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$16"/>
<wire x1="55.88" y1="152.4" x2="55.88" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$52" class="0">
<segment>
<wire x1="58.42" y1="154.94" x2="20.32" y2="154.94" width="0.1524" layer="91"/>
<wire x1="20.32" y1="154.94" x2="20.32" y2="17.78" width="0.1524" layer="91"/>
<wire x1="20.32" y1="17.78" x2="68.58" y2="17.78" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_D0"/>
<wire x1="68.58" y1="17.78" x2="68.58" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$18"/>
<wire x1="58.42" y1="154.94" x2="58.42" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$53" class="0">
<segment>
<wire x1="60.96" y1="157.48" x2="17.78" y2="157.48" width="0.1524" layer="91"/>
<wire x1="17.78" y1="157.48" x2="17.78" y2="15.24" width="0.1524" layer="91"/>
<wire x1="17.78" y1="15.24" x2="71.12" y2="15.24" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_A0"/>
<wire x1="71.12" y1="15.24" x2="71.12" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$20"/>
<wire x1="60.96" y1="157.48" x2="60.96" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$54" class="0">
<segment>
<wire x1="63.5" y1="160.02" x2="15.24" y2="160.02" width="0.1524" layer="91"/>
<wire x1="15.24" y1="160.02" x2="15.24" y2="12.7" width="0.1524" layer="91"/>
<wire x1="15.24" y1="12.7" x2="73.66" y2="12.7" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_A1"/>
<wire x1="73.66" y1="12.7" x2="73.66" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$22"/>
<wire x1="63.5" y1="160.02" x2="63.5" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$55" class="0">
<segment>
<wire x1="66.04" y1="162.56" x2="12.7" y2="162.56" width="0.1524" layer="91"/>
<wire x1="12.7" y1="162.56" x2="12.7" y2="10.16" width="0.1524" layer="91"/>
<wire x1="12.7" y1="10.16" x2="76.2" y2="10.16" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_A2"/>
<wire x1="76.2" y1="10.16" x2="76.2" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$24"/>
<wire x1="66.04" y1="162.56" x2="66.04" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$56" class="0">
<segment>
<wire x1="68.58" y1="165.1" x2="10.16" y2="165.1" width="0.1524" layer="91"/>
<wire x1="10.16" y1="165.1" x2="10.16" y2="7.62" width="0.1524" layer="91"/>
<wire x1="10.16" y1="7.62" x2="78.74" y2="7.62" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="PPU_A3"/>
<wire x1="78.74" y1="7.62" x2="78.74" y2="33.02" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$26"/>
<wire x1="68.58" y1="165.1" x2="68.58" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$57" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A4"/>
<wire x1="81.28" y1="33.02" x2="81.28" y2="5.08" width="0.1524" layer="91"/>
<wire x1="81.28" y1="5.08" x2="7.62" y2="5.08" width="0.1524" layer="91"/>
<wire x1="7.62" y1="5.08" x2="7.62" y2="167.64" width="0.1524" layer="91"/>
<wire x1="7.62" y1="167.64" x2="71.12" y2="167.64" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$28"/>
<wire x1="71.12" y1="167.64" x2="71.12" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$58" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A5"/>
<wire x1="83.82" y1="33.02" x2="83.82" y2="2.54" width="0.1524" layer="91"/>
<wire x1="83.82" y1="2.54" x2="5.08" y2="2.54" width="0.1524" layer="91"/>
<wire x1="5.08" y1="2.54" x2="5.08" y2="170.18" width="0.1524" layer="91"/>
<wire x1="5.08" y1="170.18" x2="76.2" y2="170.18" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$32"/>
<wire x1="76.2" y1="170.18" x2="76.2" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$59" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_A6"/>
<wire x1="86.36" y1="33.02" x2="86.36" y2="0" width="0.1524" layer="91"/>
<wire x1="86.36" y1="0" x2="2.54" y2="0" width="0.1524" layer="91"/>
<wire x1="2.54" y1="0" x2="2.54" y2="172.72" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$34"/>
<wire x1="2.54" y1="172.72" x2="78.74" y2="172.72" width="0.1524" layer="91"/>
<wire x1="78.74" y1="172.72" x2="78.74" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$60" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CIRAM_A10"/>
<wire x1="88.9" y1="33.02" x2="88.9" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="88.9" y1="-2.54" x2="0" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="0" y1="-2.54" x2="0" y2="175.26" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$36"/>
<wire x1="0" y1="175.26" x2="81.28" y2="175.26" width="0.1524" layer="91"/>
<wire x1="81.28" y1="175.26" x2="81.28" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$61" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="PPU_/RD"/>
<wire x1="91.44" y1="33.02" x2="91.44" y2="-5.08" width="0.1524" layer="91"/>
<wire x1="91.44" y1="-5.08" x2="-2.54" y2="-5.08" width="0.1524" layer="91"/>
<wire x1="-2.54" y1="-5.08" x2="-2.54" y2="177.8" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="P$38"/>
<wire x1="-2.54" y1="177.8" x2="83.82" y2="177.8" width="0.1524" layer="91"/>
<wire x1="83.82" y1="177.8" x2="83.82" y2="139.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="/ROMSEL"/>
<wire x1="109.22" y1="68.58" x2="109.22" y2="71.12" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$40"/>
<wire x1="109.22" y1="71.12" x2="99.06" y2="71.12" width="0.1524" layer="91"/>
<wire x1="99.06" y1="71.12" x2="99.06" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D0"/>
<wire x1="111.76" y1="68.58" x2="111.76" y2="73.66" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$38"/>
<wire x1="111.76" y1="73.66" x2="101.6" y2="73.66" width="0.1524" layer="91"/>
<wire x1="101.6" y1="73.66" x2="101.6" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D1"/>
<wire x1="114.3" y1="68.58" x2="114.3" y2="76.2" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$36"/>
<wire x1="114.3" y1="76.2" x2="104.14" y2="76.2" width="0.1524" layer="91"/>
<wire x1="104.14" y1="76.2" x2="104.14" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D2"/>
<wire x1="116.84" y1="68.58" x2="116.84" y2="78.74" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$34"/>
<wire x1="116.84" y1="78.74" x2="106.68" y2="78.74" width="0.1524" layer="91"/>
<wire x1="106.68" y1="78.74" x2="106.68" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D3"/>
<wire x1="119.38" y1="68.58" x2="119.38" y2="81.28" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$32"/>
<wire x1="119.38" y1="81.28" x2="109.22" y2="81.28" width="0.1524" layer="91"/>
<wire x1="109.22" y1="81.28" x2="109.22" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D4"/>
<wire x1="121.92" y1="68.58" x2="121.92" y2="83.82" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$28"/>
<wire x1="121.92" y1="83.82" x2="114.3" y2="83.82" width="0.1524" layer="91"/>
<wire x1="114.3" y1="83.82" x2="114.3" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D5"/>
<wire x1="124.46" y1="68.58" x2="124.46" y2="86.36" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$26"/>
<wire x1="124.46" y1="86.36" x2="116.84" y2="86.36" width="0.1524" layer="91"/>
<wire x1="116.84" y1="86.36" x2="116.84" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D6"/>
<wire x1="127" y1="68.58" x2="127" y2="88.9" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$24"/>
<wire x1="127" y1="88.9" x2="119.38" y2="88.9" width="0.1524" layer="91"/>
<wire x1="119.38" y1="88.9" x2="119.38" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_D7"/>
<wire x1="129.54" y1="68.58" x2="129.54" y2="91.44" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$22"/>
<wire x1="129.54" y1="91.44" x2="121.92" y2="91.44" width="0.1524" layer="91"/>
<wire x1="121.92" y1="91.44" x2="121.92" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$17" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A14"/>
<wire x1="132.08" y1="68.58" x2="132.08" y2="93.98" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$20"/>
<wire x1="132.08" y1="93.98" x2="124.46" y2="93.98" width="0.1524" layer="91"/>
<wire x1="124.46" y1="93.98" x2="124.46" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A13"/>
<wire x1="134.62" y1="68.58" x2="134.62" y2="96.52" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$18"/>
<wire x1="134.62" y1="96.52" x2="127" y2="96.52" width="0.1524" layer="91"/>
<wire x1="127" y1="96.52" x2="127" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$19" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="CPU_A12"/>
<wire x1="137.16" y1="68.58" x2="137.16" y2="99.06" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$16"/>
<wire x1="137.16" y1="99.06" x2="129.54" y2="99.06" width="0.1524" layer="91"/>
<wire x1="129.54" y1="99.06" x2="129.54" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="M2"/>
<wire x1="139.7" y1="68.58" x2="139.7" y2="101.6" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$14"/>
<wire x1="139.7" y1="101.6" x2="132.08" y2="101.6" width="0.1524" layer="91"/>
<wire x1="132.08" y1="101.6" x2="132.08" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$21" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="SYSTEM_CLK"/>
<wire x1="142.24" y1="68.58" x2="142.24" y2="104.14" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="P$10"/>
<wire x1="142.24" y1="104.14" x2="137.16" y2="104.14" width="0.1524" layer="91"/>
<wire x1="137.16" y1="104.14" x2="137.16" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
