GDPC                                                                                <   res://.import/boi2.png-d2e5c4880b329b82c04ab43cfa03efdf.stex�      �
      ���r�J�;�Lfq�<   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�      �      �p��<f��r�g��.�$   res://Actors/Player/Player.gd.remap +      /       �0���XQ��_I%��    res://Actors/Player/Player.gdc         �       ��a�O���?�Ӱ�    res://Actors/Player/Player.tscn �      �      �褺�[d���w�,   res://Actors/Player/PlayerControl.gd.remap  @+      6        C�ȑ]} ����(   res://Actors/Player/PlayerControl.gdc   �      7      ����(x�6?a�3�a,   res://Actors/Player/Sprites/boi2.png.import `      �      ����!�{x�Ζ؏Wc   res://World/World.tscn         7       3��:ͽGw����"y�   res://default_env.tres  @      �       um�`�N��<*ỳ�8   res://icon.png  �+      i      ����󈘥Ey��
�   res://icon.png.import   �(      �      �����%��(#AB�   res://project.binary�8            _�.^���4l�80�            GDSC                  ������������τ�   �����϶�   �������ض���   ������������ڶ��   �����¶�                         	            3YY0�  PQV�  �  �  PRQ�  W�  T�  PQ`        [gd_scene load_steps=6 format=2]

[ext_resource path="res://Actors/Player/Player.gd" type="Script" id=1]
[ext_resource path="res://Actors/Player/Sprites/boi2.png" type="Texture" id=2]
[ext_resource path="res://Actors/Player/PlayerControl.gd" type="Script" id=3]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 18.9223, 15.7296 )

[sub_resource type="RectangleShape2D" id=2]
extents = Vector2( 4.47129, 1.19158 )

[node name="Player" type="KinematicBody2D"]
z_as_relative = false
script = ExtResource( 1 )

[node name="Texture" type="Sprite" parent="."]
texture = ExtResource( 2 )

[node name="DefaultCollision" type="CollisionShape2D" parent="."]
position = Vector2( 2.94441, 0 )
shape = SubResource( 1 )

[node name="RifleColision" type="CollisionShape2D" parent="."]
position = Vector2( 26.5916, 4.02885 )
shape = SubResource( 2 )

[node name="PlayerControl" type="Node2D" parent="."]
script = ExtResource( 3 )
               GDSC      
      �      ���ӄ�   ����Ҷ��   �������϶���   �����Ķ�   �����϶�   ������������������Ŷ   �����¶�   �ڶ�   ���������������Ŷ���   ����׶��   ����¶��   ����������������Ҷ��   ������ж   ������¶   ������������������������ض��   ζ��   ϶��   ���������Ҷ�   �������������Ӷ�   �                          aim       ui_left             ui_right      ui_down       ui_up                            	                           	      
   "      #      *      1      6      7      >      G      T      Z      c      i      r      x      �      �      �      �      �      �      �      3YY;�  YY;�  �  PQYY;�  �  YY0�  PQV�  �  P�  QYY0�  P�  QV�  �  �1  P�  Q�  �  P�  QYY0�  P�	  QV�  &�
  T�  P�  QV�  �  T�  PQT�  P�  PQQ�  �  �  PQ�  &�
  T�  P�  QV�  �  T�  �  �  &�
  T�  P�  QV�  �  T�  �  �  &�
  T�  P�  QV�  �  T�  �  �  &�
  T�  P�	  QV�  �  T�  �  �  �  �  �  T�  PQ�  �  �  �  �  T�  PQT�  P�  Q`         GDST@   @           {
  PNG �PNG

   IHDR   @   @   �iq�  
>IDATx��]l\����uB>��cL����JT
�!JU�5U�I*��/-	/��bH��'Y;���JҪ ���I��4�T��CQ[��R��PB ��+ı�>���w��݄�������{g���9s�̬�*�ex��ޘ%�����[�zc��zPo$2_V���u���9j�d&�_#�D�Skp���k$ �	��0���0ٽឪ�f���XSy�YbUN0_�j��af�Z1��W%����w`Ô{AL���+W��\�4��5�[Ƙ����T��p	���D�����E$�? _�s�<�J0�umu�@ccc��-�}�W��z"c��vቼ�gU� g��,�N����8�N�|�K��S�ɤ�U9���a��cP��Ƙ'��7��!ݿ�T�.�����JM �d��*4S�����x��YF��u΄�[@	���� l]�b�w-1		����R��w8ݍ1�8@oe�����tZ%���P�8� `G��X׹y��T��n�wn)��FО���^ �i:4��tX�4�XD��1��k!AΤHv�<v����ֵ@n��ً-ט��(��h��c����،�=��Q�*� � !8�l?J��Q�cU��u]?EExd-{6�*ه���4f ��ZT,��-�%��� �(a
~Ye�� c�ip=O)/�^� 5���z7��ݹ�[��a8���ݕ5,a�y]D~��z\�1U�2Qn5�������S���k�x��d*9��g�����J!
ω����2~���e�3�c�Q� ���!����u��E@ܘ�a$�����|`W�H���t�䊊A����x:����[r$��3טfWC�|9�P6.�p�Ԙ���V�q5J�k7 �;{�$��e�м3Vcغ�TLFVe�Y��L�͉6�[�>�NoD���M�KCNx�ၞL-RL�bS��ֵU D�655��2oG�Z�u]�!@{�!"I��3�|{������o��Hu}��۞�2 �*���IkYݹ�	I ��c"���1��FU�#�=_��*� �-�Q��T�.lO	�k�\;�;A���|"�F�#l�
/OWUD��e���k�`��!ې�O3j4 "��0|�RM��  �cN#D�xg`�R�w����s����Q��.���j�����99����;�z������+>�C�
x(���q�ec�Z, ��\8�;������J4!9���aU]����T5�G����c��,�ޝ}�XT Q<�
����͕�	�P*�6�D(	�(s/��8�L�
���*��-�|�	��@D.��%��`���&ȋ%UJ�%1c0�dHQ��5�[;����	��,8_� ���ø�֏�7��b�GՎ� � �9��l��`�8���2�LJ��K���|�ށ���.�*	Um���~��j����
���W_}U�mW\qE~}O>�d'�ʕ+'ɟ�%K����*&�����B#��f�V#���)�bL�*�a\�����ȉ��S�U����rٲe�O �`|��+W��po9*% *vSU�T��zNw�p����Ҁߺ��3�g�⨠��Kn�X�^���.����� �wtt���BU� V�&?��"�6�ǹ��F�4���?nY�Á�C��%���C�e˝w��������::: ����� "�^�+��Gb�7�T�G4�,~�*Q�条��?<ړ[ �u�=q��_�hn�* ���с9�ߺ<�C�;���~����z:_��&�HԺ9ZP>g�	nM����5LU��;n#9�"����h�g�|.����w}���Y[_#��'T� d2V,�	��3udr��b�Ç�V�aL,h�:���f���;�,����o��X�����7S����>^å��뻠T4;�@6��M�9�%�j�
D!y�D�M A�b�y'���1�k��ܚh����	�`��\b��!p�Z�܈zQ�A���\xzs�7Nq)J���-�&Zob48y	N�w���/����)��P~ӤVx�����\g�y\��%�r�]�g�!L���"���$�O��A���j>!��8n���>��WT�
xv�������<> �\����BK8z�(�{WT�R��A�UU�c����aܟܣ
���@� ^���s���@�<�3a����^V߷�ț�Bc��a��V��[�����]�ՑP�T�c<�Vʜ&9z<8q-���3<�9�����u)�;6�� ��2�K���G�YL�Y\x����3Bx%�Vc�j��^��o�~�?��@0\��V�v��\�\�;�EA�@�oN�y<�8�������ca~H��֧��,�3��z
��ni{"?5���x����&�eHx ����Kn\|8�aI�k9�2$�E�ړP��H!N��~�V�>���Z��|f�O��b��J���[��hU�W�=��ۙ�c���Nw��4�*���z����c��zPo�Po�Y�-@�1K@��7������y�/�-b:�    IEND�B`�         [remap]

importer="texture"
type="StreamTexture"
path="res://.import/boi2.png-d2e5c4880b329b82c04ab43cfa03efdf.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://Actors/Player/Sprites/boi2.png"
dest_files=[ "res://.import/boi2.png-d2e5c4880b329b82c04ab43cfa03efdf.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
          [gd_scene format=2]

[node name="World" type="Node2D"]
         [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDST@   @           |  PNG �PNG

   IHDR   @   @   �iq�  ?IDATx��{pTU�����;�N7	�����%"fyN�8��r\]fEgةf���X�g��F�Y@Wp\]|,�D@��	$$���	��I�n���ҝt����JW�s��}�=���|�D(���W@T0^����f��	��q!��!i��7�C���V�P4}! ���t�ŀx��dB.��x^��x�ɏN��贚�E�2�Z�R�EP(�6�<0dYF���}^Ѡ�,	�3=�_<��(P&�
tF3j�Q���Q�B�7�3�D�@�G�U��ĠU=� �M2!*��[�ACT(�&�@0hUO�u��U�O�J��^FT(Qit �V!>%���9 J���jv	�R�@&��g���t�5S��A��R��OO^vz�u�L�2�����lM��>tH
�R6��������dk��=b�K�љ�]�י�F*W�볃�\m=�13� �Є,�ˏy��Ic��&G��k�t�M��/Q]�أ]Q^6o��r�h����Lʳpw���,�,���)��O{�:א=]� :LF�[�*���'/���^�d�Pqw�>>��k��G�g���No���\��r����/���q�̾��	�G��O���t%L�:`Ƶww�+���}��ݾ ۿ��SeŔ����  �b⾻ǰ��<n_�G��/��8�Σ�l]z/3��g����sB��tm�tjvw�:��5���l~�O���v��]ǚ��֩=�H	u���54�:�{"������}k����d���^��`�6�ev�#Q$�ήǞ��[�Ặ�e�e��Hqo{�59i˲����O+��e������4�u�r��z�q~8c
 �G���7vr��tZ5�X�7����_qQc�[����uR��?/���+d��x�>r2����P6����`�k��,7�8�ɿ��O<Ė��}AM�E%�;�SI�BF���}��@P�yK�@��_:����R{��C_���9������
M��~����i����������s���������6�,�c�������q�����`����9���W�pXW]���:�n�aұt~9�[���~e�;��f���G���v0ԣ� ݈���y�,��:j%gox�T
�����kְ�����%<��A`���Jk?���� gm���x�*o4����o��.�����逊i�L����>���-���c�����5L����i�}�����4����usB������67��}����Z�ȶ�)+����)+H#ۢ�RK�AW�xww%��5�lfC�A���bP�lf��5����>���`0ċ/oA-�,�]ĝ�$�峋P2/���`���;����[Y��.&�Y�QlM���ƌb+��,�s�[��S ��}<;���]�:��y��1>'�AMm����7q���RY%9)���ȡI�]>�_l�C����-z�� ;>�-g�dt5іT�Aͺy�2w9���d�T��J�}u�}���X�Ks���<@��t��ebL������w�aw�N����c����F���3
�2먭�e���PQ�s�`��m<1u8�3�#����XMڈe�3�yb�p�m��܇+��x�%O?CmM-Yf��(�K�h�بU1%?I�X�r��� ��n^y�U�����1�玒�6..e��RJrRz�Oc������ʫ��]9���ZV�\�$IL�OŨ��{��M�p�L56��Wy��J�R{���FDA@
��^�y�������l6���{�=��ή�V�hM�V���JK��:��\�+��@�l/���ʧ����pQ��������׷Q^^�(�T������|.���9�?I�M���>���5�f欙X�VƎ-f͚ո���9����=�m���Y���c��Z�̚5��k~���gHHR�Ls/l9²���+ ����:��杧��"9�@��ad�ŝ��ѽ�Y���]O�W_�`Ֆ#Դ8�z��5-N^�r�Z����h���ʆY���=�`�M���Ty�l���.	�/z��fH���������֗�H�9�f������G� ̛<��q��|�]>ں}�N�3�;i�r"�(2RtY���4X���F�
�����8 �[�\锰�b`�0s�:���v���2�f��k�Zp��Ω&G���=��6em.mN�o.u�fԐc��i����C���u=~{�����a^�UH������¡,�t(jy�Q�ɋ����5�Gaw��/�Kv?�|K��(��SF�h�����V��xȩ2St쯹���{6b�M/�t��@0�{�Ԫ�"�v7�Q�A�(�ľR�<	�w�H1D�|8�]�]�Ո%����jҢ꯸hs�"~꯸P�B�� �%I}}��+f�����O�cg�3rd���P�������qIڻ]�h�c9��xh )z5��� �ƾ"1:3���j���'1;��#U�失g���0I}�u3.)@�Q�A�ĠQ`I�`�(1h��t*�:�>'��&v��!I?�/.)@�S�%q�\���l�TWq�������լ�G�5zy6w��[��5�r���L`�^���/x}�>��t4���cݦ�(�H�g��C�EA�g�)�Hfݦ��5�;q-���?ư�4�����K����XQ*�av�F��������񵏷�;>��l�\F��Þs�c�hL�5�G�c�������=q�P����E �.���'��8Us�{Ǎ���#������q�HDA`b��%����F�hog���|�������]K�n��UJ�}������Dk��g��8q���&G����A�RP�e�$'�i��I3j�w8������?�G�&<	&䪬R��lb1�J����B$�9�꤮�ES���[�������8�]��I�B!
�T
L:5�����d���K30"-	�(��D5�v��#U�����jԔ�QR�GIaó�I3�nJVk���&'��q����ux��AP<�"�Q�����H�`Jң�jP(D��]�����`0��+�p�inm�r�)��,^�_�rI�,��H>?M-44���x���"� �H�T��zIty����^B�.��%9?E����П�($@H!�D��#m�e���vB(��t �2.��8!���s2Tʡ �N;>w'����dq�"�2����O�9$�P	<(��z�Ff�<�z�N��/yD�t�/?�B.��A��>��i%�ǋ"�p n� ���]~!�W�J���a�q!n��V X*�c �TJT*%�6�<d[�    IEND�B`�        [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
[remap]

path="res://Actors/Player/Player.gdc"
 [remap]

path="res://Actors/Player/PlayerControl.gdc"
          �PNG

   IHDR   @   @   �iq�  0IDATx��}pTU����L����W�$�@HA�%"fa��Yw�)��A��Egةf���X�g˱��tQ���Eq�!�|K�@BHH:�t>�;�����1!ݝn�A�_UWw����{λ��sϽO�q汤��X,�q�z�<�q{cG.;��]�_�`9s��|o���:��1�E�V� ~=�	��ݮ����g[N�u�5$M��NI��-
�"(U*��@��"oqdYF�y�x�N�e�2���s����KҦ`L��Z)=,�Z}"
�A�n{�A@%$��R���F@�$m������[��H���"�VoD��v����Kw�d��v	�D�$>	�J��;�<�()P�� �F��
�< �R����&�կ��� ����������%�u̚VLNfڠus2�̚VL�~�>���mOMJ���J'R��������X����׬X�Ϲ虾��6Pq������j���S?�1@gL���±����(�2A�l��h��õm��Nb�l_�U���+����_����p�)9&&e)�0 �2{��������1���@LG�A��+���d�W|x�2-����Fk7�2x��y,_�_��}z��rzy��%n�-]l����L��;
�s���:��1�sL0�ڳ���X����m_]���BJ��im�  �d��I��Pq���N'�����lYz7�����}1�sL��v�UIX���<��Ó3���}���nvk)[����+bj�[���k�������cݮ��4t:= $h�4w:qz|A��٧�XSt�zn{�&��õmQ���+�^�j�*��S��e���o�V,	��q=Y�)hԪ��F5~����h�4 *�T�o��R���z�o)��W�]�Sm銺#�Qm�]�c�����v��JO��?D��B v|z�կ��܈�'�z6?[� ���p�X<-���o%�32����Ρz�>��5�BYX2���ʦ�b��>ǣ������SI,�6���|���iXYQ���U�҅e�9ma��:d`�iO����{��|��~����!+��Ϧ�u�n��7���t>�l捊Z�7�nвta�Z���Ae:��F���g�.~����_y^���K�5��.2�Zt*�{ܔ���G��6�Y����|%�M	���NPV.]��P���3�8g���COTy�� ����AP({�>�"/��g�0��<^��K���V����ϫ�zG�3K��k���t����)�������6���a�5��62Mq����oeJ�R�4�q�%|�� ������z���ä�>���0�T,��ǩ�����"lݰ���<��fT����IrX>� � ��K��q�}4���ʋo�dJ��م�X�sؘ]hfJ�����Ŧ�A�Gm߽�g����YG��X0u$�Y�u*jZl|p������*�Jd~qcR�����λ�.�
�r�4���zپ;��AD�eЪU��R�:��I���@�.��&3}l
o�坃7��ZX��O�� 2v����3��O���j�t	�W�0�n5����#è����%?}����`9۶n���7"!�uf��A�l܈�>��[�2��r��b�O�������gg�E��PyX�Q2-7���ʕ������p��+���~f��;����T	�*�(+q@���f��ϫ����ѓ���a��U�\.��&��}�=dd'�p�l�e@y��
r�����zDA@����9�:��8�Y,�����=�l�֮��F|kM�R��GJK��*�V_k+��P�,N.�9��K~~~�HYY��O��k���Q�����|rss�����1��ILN��~�YDV��-s�lfB֬Y�#.�=�>���G\k֬fB�f3��?��k~���f�IR�lS'�m>²9y���+ �v��y��M;NlF���A���w���w�b���Л�j�d��#T��b���e��[l<��(Z�D�NMC���k|Zi�������Ɗl��@�1��v��Щ�!曣�n��S������<@̠7�w�4X�D<A`�ԑ�ML����jw���c��8��ES��X��������ƤS�~�׾�%n�@��( Zm\�raҩ���x��_���n�n���2&d(�6�,8^o�TcG���3���emv7m6g.w��W�e
�h���|��Wy��~���̽�!c� �ݟO�)|�6#?�%�,O֫9y������w��{r�2e��7Dl �ׇB�2�@���ĬD4J)�&�$
�HԲ��
/�߹�m��<JF'!�>���S��PJ"V5!�A�(��F>SD�ۻ�$�B/>lΞ�.Ϭ�?p�l6h�D��+v�l�+v$Q�B0ūz����aԩh�|9�p����cƄ,��=Z�����������Dc��,P��� $ƩЩ�]��o+�F$p�|uM���8R��L�0�@e'���M�]^��jt*:��)^�N�@�V`�*�js�up��X�n���tt{�t:�����\�]>�n/W�\|q.x��0���D-���T��7G5jzi���[��4�r���Ij������p�=a�G�5���ͺ��S���/��#�B�EA�s�)HO`���U�/QM���cdz
�,�!�(���g�m+<R��?�-`�4^}�#>�<��mp��Op{�,[<��iz^�s�cü-�;���쾱d����xk瞨eH)��x@���h�ɪZNU_��cxx�hƤ�cwzi�p]��Q��cbɽcx��t�����M|�����x�=S�N���
Ͽ�Ee3HL�����gg,���NecG�S_ѠQJf(�Jd�4R�j��6�|�6��s<Q��N0&Ge
��Ʌ��,ᮢ$I�痹�j���Nc���'�N�n�=>|~�G��2�)�D�R U���&ՠ!#1���S�D��Ǘ'��ೃT��E�7��F��(?�����s��F��pC�Z�:�m�p�l-'�j9QU��:��a3@0�*%�#�)&�q�i�H��1�'��vv���q8]t�4����j��t-}IـxY�����C}c��-�"?Z�o�8�4Ⱦ���J]/�v�g���Cȷ2]�.�Ǣ ��Ս�{0
�>/^W7�_�����mV铲�
i���FR��$>��}^��dُ�۵�����%��*C�'�x�d9��v�ߏ � ���ۣ�Wg=N�n�~������/�}�_��M��[���uR�N���(E�	� ������z��~���.m9w����c����
�?���{�    IEND�B`�       ECFG      _global_script_classes             _global_script_class_icons             application/config/name0      &   Новый игровой проект     application/run/main_scene(         res://Actors/Player/Player.tscn    application/config/icon         res://icon.png     input/ui_left\              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script               InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script               InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   A      unicode           echo          script            input/ui_right\              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script               InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script               InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   D      unicode           echo          script            input/ui_up\              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script               InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script               InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   W      unicode           echo          script            input/ui_down\              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script               InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script               InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   S      unicode           echo          script         	   input/aim�              events              InputEventMouseButton         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           button_mask           position              global_position               factor       �?   button_index         pressed           doubleclick           script               deadzone      ?)   rendering/environment/default_environment          res://default_env.tres             GDPC