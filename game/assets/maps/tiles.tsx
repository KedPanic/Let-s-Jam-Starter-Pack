<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.2" name="Tiles" tilewidth="8" tileheight="8" tilecount="256" columns="16">
 <image source="../sprites/tiles.png" width="128" height="128"/>
 <tile id="0">
  <objectgroup draworder="index" id="2">
   <object id="1" x="4" y="4" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="1">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="4" width="8" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="2">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="4" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="3">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="8" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
   <object id="2" x="0" y="4" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="4">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="8" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
   <object id="2" x="4" y="4" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="16">
  <objectgroup draworder="index" id="2">
   <object id="1" x="4" y="0" width="4" height="8">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="17">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="8" height="8">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="18">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="4" height="8">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="19">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
   <object id="2" x="0" y="4" width="8" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="20">
  <objectgroup draworder="index" id="2">
   <object id="1" x="4" y="0" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
   <object id="2" x="0" y="4" width="8" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="32">
  <objectgroup draworder="index" id="2">
   <object id="1" x="4" y="0" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="33">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="8" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="34">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="4" height="4">
    <properties>
     <property name="collidable" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="35">
  <animation>
   <frame tileid="35" duration="500"/>
   <frame tileid="36" duration="150"/>
   <frame tileid="37" duration="150"/>
   <frame tileid="38" duration="150"/>
   <frame tileid="39" duration="150"/>
   <frame tileid="38" duration="150"/>
   <frame tileid="37" duration="150"/>
   <frame tileid="36" duration="150"/>
  </animation>
 </tile>
 <tile id="55">
  <animation>
   <frame tileid="48" duration="100"/>
   <frame tileid="49" duration="100"/>
   <frame tileid="50" duration="100"/>
   <frame tileid="51" duration="100"/>
   <frame tileid="52" duration="100"/>
   <frame tileid="53" duration="100"/>
   <frame tileid="54" duration="100"/>
   <frame tileid="55" duration="100"/>
  </animation>
 </tile>
 <tile id="67" probability="2"/>
 <tile id="68" probability="2"/>
 <tile id="70" probability="2"/>
 <tile id="71" probability="2"/>
 <tile id="72" probability="2"/>
 <tile id="75" probability="2"/>
 <tile id="76" probability="2"/>
 <tile id="77" probability="3"/>
 <tile id="78" probability="3"/>
 <tile id="79" probability="3"/>
 <tile id="83" probability="2"/>
 <tile id="90" probability="2"/>
 <tile id="91" probability="2"/>
 <tile id="92" probability="2"/>
 <tile id="93" probability="3"/>
 <tile id="94" probability="3"/>
 <tile id="95" probability="3"/>
 <wangsets>
  <wangset name="Terrains" type="corner" tile="-1">
   <wangcolor name="Rock" color="#ff0000" tile="0" probability="1"/>
   <wangtile tileid="0" wangid="0,0,0,1,0,0,0,0"/>
   <wangtile tileid="1" wangid="0,0,0,1,0,1,0,0"/>
   <wangtile tileid="2" wangid="0,0,0,0,0,1,0,0"/>
   <wangtile tileid="3" wangid="0,1,0,0,0,1,0,1"/>
   <wangtile tileid="4" wangid="0,1,0,1,0,0,0,1"/>
   <wangtile tileid="16" wangid="0,1,0,1,0,0,0,0"/>
   <wangtile tileid="17" wangid="0,1,0,1,0,1,0,1"/>
   <wangtile tileid="18" wangid="0,0,0,0,0,1,0,1"/>
   <wangtile tileid="19" wangid="0,0,0,1,0,1,0,1"/>
   <wangtile tileid="20" wangid="0,1,0,1,0,1,0,0"/>
   <wangtile tileid="32" wangid="0,1,0,0,0,0,0,0"/>
   <wangtile tileid="33" wangid="0,1,0,0,0,0,0,1"/>
   <wangtile tileid="34" wangid="0,0,0,0,0,0,0,1"/>
  </wangset>
 </wangsets>
</tileset>
