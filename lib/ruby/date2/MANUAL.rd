=begin
= date2 - �⤦�ҤȤĤ����շ׻����饹

== Date

=== �Ѹ�����

�����Ĥ��Ѹ������ϡ�ISO 8601������� JIS X 0301 �˴�Ť��ޤ���

==== ������

�����դϡ���ǯ���������������ν����ˤ�ä�
���ꤵ���������������դǤ���

�Ĥޤꡢ��������������ǯ�����ˤ�����դǤ���

==== ǯ���̻��� (ǯ����)

ǯ���̻��� (ǯ����) �ϡ���ǯ���������ǯ����ν����ˤ�äƻ��ꤵ���
������������դǤ���

==== ������

�����դϡ��񽵤���ǯ��ν����ˤ�����դǤ���

�񽵤ϡ���ǯ��ν����ˤ�äƻ��ꤵ��������7���δ��֤Ǥ��ꡢ���ˤ���
�Ϥޤ�ޤ�������ǯ����1�񽵤ϡ��ǽ����������ޤཱུ�Ȥ��ޤ�������ϡ�1
��4����ޤཱུ��Ʊ���Ǥ���

==== ��ꥦ����

��ꥦ�����ϵ�����4713ǯ1��1�� (��ꥦ����) ���� (����˥å�ʿ�ѻ�) ��
�񸵤Ȥ������� (�в�����) �Ǥ���

����ʸ��ǡ�ŷʸ��Ū�ʥ�ꥦ�����Ȥϡ�����Υ�ꥦ������Ʊ����ΤǤ���
�ޤ���ǯ���Ū�ʥ�ꥦ�����Ȥϡ��������ˤ���������������λϤޤ�Ȥ���
ή���Ǥ���

����ʸ��ǡ�ñ�ˡ֥�ꥦ�����פȤ��ä���硢���������Υ�ꥦ�����Ǥ�
������ǯ���Ū�ʥ�ꥦ�����פ��̣���Ƥ��ޤ���

==== ������ꥦ����

������ꥦ����������1858ǯ11��17�� (���쥴�ꥪ��) ����/���� (����������) ��
�񸵤Ȥ������� (�в�����) �Ǥ���

����ʸ��ǡ�ŷʸ��Ū�ʽ�����ꥦ�����Ȥϡ�����ν�����ꥦ������Ʊ����
�ΤǤ����ޤ���ǯ���Ū�ʽ�����ꥦ�����Ȥϡ��������ˤ����������������
�Ϥޤ�Ȥ���ή���Ǥ���

����ʸ��ǡ�ñ�ˡֽ�����ꥦ�����פȤ��ä���硢���������ν�����ꥦ
�����Ǥʤ�����ǯ���Ū�ʽ�����ꥦ�����פ��̣���Ƥ��ޤ���

=== �����ѡ����饹

Object

=== ���󥯥롼�ɤ��Ƥ���⥸�塼��

Comparable

=== ���饹�᥽�å�

: civil([year[, mon[, mday[, start]]]])
: new([year[, mon[, mday[, start]]]])
  �����դ������������ե��֥������Ȥ��������ޤ���

  ���Υ��饹�Ǥϡ���������ǯ��ŷʸ�ؤ�ή���Ǵ��ꤷ�ޤ���
  1ǯ��������ǯ����ǯ������-1ǯ���Τ褦�ˤ��ޤ���
  �����ӷ�������顢
  �ޤ������ο��Ǥʤ���Фʤ�ޤ��� (��ΤȤ��ϺǸ夫��ν���)��
  ���Ǥ��äƤϤʤ�ޤ���

  �Ǹ�ΰ����ϡ����쥴�ꥪ���Ĥ����Ϥ᤿���򤢤�魯��ꥦ�����Ǥ���
  ���쥴�ꥪ��λ���Ȥ��� Date::GREGORIAN��
  ��ꥦ����λ���Ȥ��� Date::JULIAN ��Ϳ���뤳�Ȥ�Ǥ��ޤ���
  ��ά�������ϡ�Date::ITALY (1582ǯ10��15��) �ˤʤ�ޤ���

  jd �⻲�Ȥ��Ƥ���������

: commercial([cwyear[, cweek[, cwday[, start]]]])
  �����դ������������ե��֥������Ȥ��������ޤ���

  ��������ӽ����� (����) ���顢
  �ޤ������ο��Ǥʤ���Фʤ�ޤ���(��ΤȤ��ϺǸ夫��ν���)��
  ���Ǥ��äƤϤʤ�ޤ���

  ���Υ᥽�åɤ˲����������դ�Ϳ���뤳�ȤϤǤ��ޤ���

  jd������� new �⻲�Ȥ��Ƥ���������

: jd([jd[, start]])
  ��ꥦ�����������������ե��֥������Ȥ��������ޤ���

  ���Υ��饹�Τ����Ĥ��ν��פʥ᥽�åɤǡ�
  ��Υ�ꥦ�������ݾڤ���ޤ���

  new �⻲�Ȥ��Ƥ���������

: nth_kday([year[, mon[, n[, k[, start]]]]])
  ���η�� N���� (-5 ���� 5�����������ϤΤ���) �� K���� (0-6) ���֤��ޤ���

: ordinal([year[, yday[, start]]])
  ǯ���̻��� (ǯ����) �������������ե��֥������Ȥ��������ޤ���

  ǯ�������顢
  �ޤ������ο��Ǥʤ���Фʤ�ޤ��� (��ΤȤ��ϺǸ夫��ν���)��
  ���Ǥ��äƤϤʤ�ޤ���

  jd������� new �⻲�Ȥ��Ƥ���������

: parse([str[, complete[, start]]])
  Ϳ����줿����ɽ������Ϥ���
  ���ξ���˴�Ť������ե��֥������Ȥ��������ޤ���

  ��ά��ǽ�ʤդ����ܤΰ��������ǡ�ǯ�� "00" ���� "99" ���ϰϤǤ���С�
  ǯ�β�2��ɽ���Ǥ���Ȥߤʤ�������䤤�ޤ���
  �ʤ�����ά�������ϡ����Ȥߤʤ��ޤ���

  _parse �����ѤǤ��ޤ���
  ���Υ᥽�åɤ� parse �Ȼ��Ƥ��ޤ��������ե��֥������Ȥ����������ˡ�
  �������������Ǥ�ϥå�����֤��ޤ���

: strptime([str[, format[, start]]])
  Ϳ����줿����������ɽ������Ϥ���
  ���ξ���˴�Ť������ե��֥������Ȥ��������ޤ���

  ���Ȥ��С��Ĥ��Τ褦�ʽ񼰤�����Ĥ��ޤ�:

    %Y-%m-%d
    %Y-%j
    %G-W%V-%u
    %s
    %Q

  _strptime �����ѤǤ��ޤ���
  ���Υ᥽�åɤ� strptime �Ȼ��Ƥ��ޤ��������ե��֥����������������ˡ�
  �������������Ǥ�ϥå�����֤��ޤ���

  strptime(3)������� strftime �⻲�Ȥ��Ƥ���������

: today([start])
  ���ߤ����դ������������ե��֥������Ȥ��������ޤ���

: valid_civil? (year, mon, mday[, start])
: valid_date? (year, mon, mday[, start])
  �����������դǤ���п��������Ǥʤ��ʤ鵶���֤��ޤ���

  jd������� civil �⻲�Ȥ��Ƥ���������

: valid_commercial? (cwyear, cweek, cwday[, start])
  �����������դǤ���п��������Ǥʤ��ʤ鵶���֤��ޤ���

  jd������� commercial �⻲�Ȥ��Ƥ���������

: valid_jd? (jd[, start])
  �����֤��ޤ���

  �о����Τ����Ѱդ���Ƥ��ޤ������º�Ū�˰�̣�Ϥ���ޤ���

  jd �⻲�Ȥ��Ƥ���������

: valid_ordinal? (year, yday[, start])
  ������ǯ���̻��� (ǯ����) �Ǥ���п��������Ǥʤ��ʤ鵶���֤��ޤ���

  jd������� ordinal �⻲�Ȥ��Ƥ���������

=== �᥽�å�

: self + n
  self ���� n ��������ե��֥������Ȥ��֤��ޤ���
  n �Ͽ��ͤǤʤ���Фʤ�ޤ���

: self - x
  x �����ե��֥������Ȥʤ顢�դ��Ĥκ����֤��ޤ���
  ���뤤��
  x �����ͤʤ�С�self ��� x ���������դ��֤��ޤ���

: self << n
  self ��� n �����������ե��֥������Ȥ��֤��ޤ���
  n �Ͽ��ͤǤʤ���Фʤ�ޤ���

: self <=> other
  �դ��Ĥ���Ӥ���-1���������뤤�� 1 ���֤��ޤ���
  other �����ե��֥������Ȥ���
  ŷʸ��Ū�ʥ�ꥦ�����򤢤�魯���ͤǤʤ���Фʤ�ޤ���

: self === other
  Ʊ�����ʤ鿿���֤��ޤ���

: self >> n
  self ���� n ���������ե��֥������Ȥ��֤��ޤ���
  n �Ͽ��ͤǤʤ���Фʤ�ޤ���

: asctime
: ctime
  asctime(3) �񼰤�ʸ������֤��ޤ� (�������������� "\n\0" �Ͻ���)��

: cwday
  �񽵤��� (����) ���֤��ޤ� (1-7�����ˤ�1)��

: cweek
  �񽵤��֤��ޤ� (1-53)��

: cwyear
  �񽵤ˤ�����ǯ���֤��ޤ���

: downto(min){|date| ...}
  ���Υ᥽�åɤϡ�(({step(min, -1){|date| ...}})) �������Ǥ���

: england
  ���Υ᥽�åɤϡ�(({new_start(Date::ENGLAND)})) �������Ǥ���

: gregorian
  ���Υ᥽�åɤϡ�(({new_start(Date::GREGORIAN)})) �������Ǥ���

: iso8601
: rfc3339
  ISO 8601 �񼰤�ʸ������֤��ޤ� (����ɽ���ϤĤ����ޤ���)��

: italy
  ���Υ᥽�åɤϡ�(({new_start(Date::ITALY)})) �������Ǥ���

: jd
  ��ꥦ�������֤��ޤ���
  �����ޤߤޤ���

  ajd �����ѤǤ��ޤ���
  ���Υ᥽�åɤ� jd �Ȼ��Ƥ��ޤ�����ŷʸ��Ū�ʥ�ꥦ�������֤��ޤ���
  �����ޤߤޤ���

: jisx0301
  JIS X 0301 �񼰤�ʸ������֤��ޤ���
  �����������������ˤĤ��Ƥ� ISO 8601 �񼰤ˤʤ�ޤ���
  �ʤ�������6ǯ�����ˤĤ��Ƥ��������������Ѥ��뤳�ȤϤ���ޤ���

: julian
  ���Υ᥽�åɤϡ�(({new_start(Date::JULIAN)})) �������Ǥ���

: leap?
  ��ǯ�ʤ鿿���֤��ޤ���

: mday
: day
  ��������֤��ޤ� (1-31)��

: mjd
  ������ꥦ�������֤��ޤ���
  ����ξ����ޤߤޤ���

  amjd �����ѤǤ��ޤ���
  ���Υ᥽�åɤ� mjd �Ȼ��Ƥ��ޤ�����ŷʸ��Ū�ʽ�����ꥦ�������֤��ޤ���
  �����ޤߤޤ���

: mon
: month
  ����֤��ޤ� (1-12)��

: new_start([start])
  self ��ʣ�����ơ����β����������ꤷ�ʤ����ޤ���
  �������ά�������ϡ�Date::ITALY (1582ǯ10��15��) �ˤʤ�ޤ���

  new �⻲�Ȥ��Ƥ���������

: next_day([n])
  ���������ե��֥������Ȥ��֤��ޤ���

: next_month([n])
  �������ե��֥������Ȥ��֤��ޤ���

: next_year([n])
  ��ǯ�����ե��֥������Ȥ��֤��ޤ���

: nth_kday?(n, k)
  ���η����NK������N���� (-5 ���� 5�����������ϤΤ���) �� K����
  (0-6) �Ǥ���п����֤��ޤ���

: prev_day([n])
  ���������ե��֥������Ȥ��֤��ޤ���

: prev_month([n])
  ��������ե��֥������Ȥ��֤��ޤ���

: prev_year([n])
  ��ǯ�����ե��֥������Ȥ��֤��ޤ���

: rfc2822
: rfc822
  RFC 2822 �񼰤�ʸ������֤��ޤ���

: start
  �������򤢤�魯��ꥦ�������֤��ޤ���

  new �⻲�Ȥ��Ƥ���������

: step(limit[, step]){|date| ...}
  �֥��å���ɾ���򷫤��֤��ޤ����֥��å������ե��֥������Ȥ�Ȥ�ޤ���
  limit �����ե��֥������ȤǤʤ���Фʤ�ޤ���
  �ޤ� step �������Ǥʤ���Фʤ�ޤ���

: strftime([format])
  Ϳ����줿���������դ�񼰤Ť��ޤ���
  �Ĥ����Ѵ����ͤ򤢤Ĥ����ޤ�:

  %A, %a, %B, %b, %C, %c, %D, %d, %e, %F, %G, %g, %H, %h, %I, %j, %k,
  %L, %l, %M, %m, %N, %n, %P, %p, %Q, %R, %r, %S, %s, %T, %t, %U, %u,
  %V, %v, %W, %w, %X, %x, %Y, %y, %Z, %z, %%, %+

  strftime(3)������� strptime �⻲�Ȥ��Ƥ���������

: succ
: next
  ���������ե��֥������Ȥ��֤��ޤ���

: to_s
  ISO 8601 �񼰤�ʸ������֤��ޤ� (����ɽ���ϤĤ����ޤ���)��

: upto(max){|date| ...}
  ���Υ᥽�åɤϡ�(({step(max, 1){|date| ...}})) �������Ǥ���

: wday
  �������֤��ޤ� (0-6������������)��

: yday
  ǯ�������֤��ޤ� (1-366)��

: year
  ǯ���֤��ޤ���


== DateTime

=== �����ѡ����饹

Date

=== ���饹�᥽�å�

: civil([year[, mon[, mday[, hour[, min[, sec[, offset[, start]]]]]]]])
: new([year[, mon[, mday[, hour[, min[, sec[, offset[, start]]]]]]]])
  �����դ����������������֥������Ȥ��������ޤ���

: commercial([cwyear[, cweek[, cwday[, hour[, min[, sec[, offset[, start]]]]]]]])
  �����դ����������������֥������Ȥ��������ޤ���

: jd([jd[, hour[, min[, sec[, offset[, start]]]]]])
  ��ꥦ���������������������֥������Ȥ��������ޤ���

: now([start])
  ���ߤλ�������������������֥������Ȥ��������ޤ���

: nth_kday([year[, mon[, n[, k, [, hour[, min[, sec[, offset[, start]]]]]]]]])
  ���η�� N���� (-5 ���� 5�����������ϤΤ���) �� K���� (0-6) ���֤��ޤ���

: ordinal([year[, yday[, hour[, min[, sec[, offset[, start]]]]]]])
  ǯ���դ����������������֥������Ȥ��������ޤ���

=== �᥽�å�

: hour
  ���֤��֤��ޤ� (0-23)��

: iso8601([n])
: rfc3339([n])
  ISO 8601 �񼰤�ʸ������֤��ޤ���
  ��ά��ǽ�ʰ����ˤ�ꡢ���������äξ������ʲ��η����Ϳ���뤳�Ȥ��Ǥ��ޤ���

: jisx0301([n])
  JIS X 0301 �񼰤�ʸ������֤��ޤ���
  ��ά��ǽ�ʰ����ˤ�ꡢ���������äξ������ʲ��η����Ϳ���뤳�Ȥ��Ǥ��ޤ���

: min
  ʬ���֤��ޤ� (0-59)��

: new_offset([offset])
  self ��ʣ�����ơ����λ��������ꤷ�ʤ����ޤ���
  �������ά�������ϡ��� (����������) �ˤʤ�ޤ���

  new �⻲�Ȥ��Ƥ���������

: offset
  �������֤��ޤ���

: sec
  �ä��֤��ޤ� (0-59)��

: zone
  �����ॾ������֤��ޤ���


= date/holiday - �˺�����Ƚ��

== Date

=== ���饹�᥽�å�

: gregorian_easter(year[, start])
: easter(year[, start])
  ���쥴�ꥪ��ˤ����롢����ǯ������פ����������֤��ޤ���

: julian_easter(year[, start])
  ��ꥦ����ˤ����롢����ǯ������פ����������֤��ޤ���

=== �᥽�å�

: easter?
  ����פ��������Ǥ���п����֤��ޤ���

: national_holiday?
  �ֹ�̱�ν����˴ؤ���ˡΧ�פˤ�������
  �⤷���ϡ������Ĥ������̤ʵ����Ǥ���п����֤��ޤ���

  ���Υ᥽�åɤϡ���Ȭ������
  �ֹ�̱�ν����˴ؤ���ˡΧ�ΰ������������ˡΧ��
  (ʿ��17ǯ5��20���泰ˡΧ43��)���б��ѤߤǤ���

  ��ʬ������ʬ������ǯ��2��Ϥ���δ���˷Ǻܤ�����Τ��������ΤǤ�����
  �����ǤϷ׻��ǵ��Ƥ��ޤ���
  �Ĥޤ꾭��ˤĤ��Ƥϴְ㤨�뤳�Ȥ⤢�뤫�⤷��ޤ���
  �ʤ���ʿ��21ǯ (2009) ʬ�ޤǤϴ������ˤ���ǧ�ѤߤǤ���

: old_national_holiday?
  �ѽ˺����Ǥ�����ä��֤��ޤ���
  ����̤������Ū����ʪ��ͭ��ޤ���


= parsedate - ���դȻ���β���

== ParseDate

=== �⥸�塼��ؿ�

: parsedate(str[, complete])
  Ϳ����줿����ɽ������Ϥ����������������Ǥ�
  ���� (ǯ�����������ʬ���á������ॾ��������) ���֤��ޤ���

  ��ά�Ǥ���Ǹ�ΰ��������ǡ�ǯ�� "00" ���� "99" ���ϰϤǤ���С�
  ǯ�β�2��ɽ���Ǥ���Ȥߤʤ�������䤤�ޤ���
  �ʤ�����ά�������ϡ����Ȥߤʤ��ޤ���

  parsedate �Ϥ��������ʽ񼰤򤢤Ĥ����ޤ���
  ���Ȥ��С��Ĥ��Τ褦��ɽ��������Ĥ��ޤ�:

    Sat
    Saturday
    1999-08-28
    21:45:09
    09:45:09 PM
    1999-08-28T21:45:09+0900
    19990828 214509
    H11.08.28T21:45:09Z
    Sat Aug 28 21:45:09 1999
    Sat Aug 28 21:45:09 JST 1999
    Sat, 28 Aug 1999 21:45:09 -0400
    Saturday, 28-Aug-99 21:45:09 GMT
    08/28/1999
    1999/08/28

  Date::parse �⻲�Ȥ��Ƥ���������
=end