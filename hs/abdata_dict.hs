;--------------------
%dll
abdata
%group
�f�[�^�\��
%type
�^������

;--------------------
%index
dict_new
�����C���X�^���X���\�z
%prm
self, vtype, size
array self:  �����C���X�^���X������z��ϐ�
int   vtype: �����̒l�̌^�̌^�^�C�v�l
int   size:  �v�����鏉���L���p�V�e�B
%inst
self �ɁA�V���������̃C���X�^���X�𐶐�����B�����I�ɂ́Aself �� newmod ���߂��g���B

vtype, size �ɂ��Ă� dict_init ���߂��Q�ƁB

;--------------------
%index
dict_delete
�����C���X�^���X�����
%prm
self
%inst
�����C���X�^���X self ����̂���B�����I�ɂ́Aself �� delmod ����B

;--------------------
%index
dict_init
������������
%prm
self, vtype, capa
int   vtype [vartype_int]: �����̒l�̌^�̌^�^�C�v�l
int   capa  [0]: �v�����鏉���L���p�V�e�B
%inst
�����̒��g��S��������B

��������̎����́A�l�Ƃ��� vtype �^�̒l�����B

capa ���x�̗v�f�������ɂ��炩���ߗp�ӂ����B

;--------------------
%index
dict_vartype
�����̒l�̌^
%prm
(self)
retunr: self �����l�̌^

;--------------------
%index
dict_size
�����̗v�f��
%prm
(self)
return: �������i�[���Ă���v�f�̌�
%inst
���������ۂɎ����Ă���v�f�̌��B

;--------------------
%index
dict_chain
�����̘A��(����)
%prm
self, src, conflict_policy
var src: �A�����鎫��
int conflict_policy [dict_conflict_keep]: �L�[�Փˎ��̃|���V�[
%inst
���� src �����e�v�f���Aself �ɑ}������B

src �� self �������L�[������Ƃ��A�L�[���Փ˂���Ƃ����B�Փˎ��̋����� conflict_policy �̒l�ɂ��������B

dict_conflict_update: src �̗v�f�ŏ㏑������B(self �������Ă������̃L�[�̒l�͏�����B)
dict_conflict_keep:   self �������Ă���v�f���c���B
dict_conflict_abort:  �v���O�������ُ�I��(end 1)����B�L�[�Փ˂��N���Ȃ��ƕ������Ă���Ƃ��Ɏg���B

;--------------------
%index
dict_has_key
�������L�[���܂ނ��H
%prm
(self, key)
var key: �L�[
return: �������L�[ key ���܂ނȂ�^

;--------------------
%index
dict_insert
�����ɗv�f��}������
%prm
self, key, val, conflict_policy
var key: �}������L�[
var val: �l
int conflict_policy [dict_conflict_keep]: �L�[�Փˎ��̃|���V�[
%inst
�����ɁA�L�[�� key�A�l�� val �̗v�f��}������B

self ������ key �������Ă����Ƃ��́Aconflict_policy �̒l�ɂ��������B(dict_chain ���Q�ƁB)

;--------------------
%index
dict_erase
��������v�f����������
%prm
self, key
var key: ��������v�f�̃L�[
return: �������ꂽ�Ȃ�^
%inst
���������A�L�[ key �Ƃ��̒l����������B���̂悤�ȗv�f���n�߂���Ȃ���΁A�������Ȃ��B

����ɂ�莫�����k��(dict_capacity ���������Ȃ�)���Ƃ͂Ȃ��B

;--------------------
%index
dict_try_get
�����̗v�f�l�̎擾
%prm
(self, result, key)
var result: �l��������ϐ�
var key: �l���擾�������v�f�̃L�[
return: ����������^
%inst
�������L�[ key �����ꍇ�́A����ɑΉ�����l�� result �ɑ�����āAtrue ��Ԃ��B�����Ȃ��ꍇ�́Afalse ��Ԃ��B
;--------------------
%index
dict_get
�����̗v�f�̒l
%prm
(self, key)
var key: �l���擾�������v�f�̃L�[
return: key �ɑΉ�����v�f�̒l
%inst
�����̃L�[ key �ɑΉ�����v�f�̒l��Ԃ��B���̂悤�ȗv�f���Ȃ���΁A�G���[�ŏI������B
%href
dict_ref

;--------------------
%index
dict_try_dup
�����̗v�f�ւ̎Q��
%prm
(self, ref, key)
array ref: �N���[���ϐ��ɂ���z��ϐ�
var key: �L�[
return: ����������^
%inst
�������L�[ key �����ꍇ�́Aref ������ɑΉ�����v�f�ւ̃N���[���ϐ��ɂ��āAtrue ��Ԃ��B�����Ȃ��ꍇ�́Afalse ��Ԃ��B

;--------------------
%index
dict_ref
�����̗v�f�̒l�̎Q��
%prm
(self, key)
var key: �L�[
return: key �ɑΉ�����v�f�ւ̃N���[��
%inst
key �ɑΉ�����v�f�ւ̃N���[����Ԃ��B

;--------------------
%index
dict_iter_kv
�����̗v�f���Ƃ̔���
%prm
self, key, val
var key: �L�[�ւ̃N���[���ɂȂ�ϐ�
var val: �l�ւ̃N���[���ɂȂ�ϐ�
%inst
�������܂ފe�v�f�ɂ��āAdict_iter_kv_end �܂ł��J��Ԃ����s����B

�e���[�v�ɂ����āAkey ��v�f�̃L�[�̃N���[���ɂ��Aval ��l�̃N���[���ɂ���B�������Akey, val �����������Ă͂����Ȃ��B

�v�f�̏��Ԃ͓��Ɍ��܂��Ă��Ȃ��B

���[�v�̓r���� dict_rebuild ��������ƁA���[�v���������s���Ȃ��B���̂��߁Adict_insert, dict_chain �Ȃǂ́A�V�����v�f��ǉ�����\�������閽�߂����s���Ă͂����Ȃ� (���ۂɗv�f��ǉ����Ȃ��ꍇ���_��)�B����A�v�f�����炷 dict_erase �͖��Ȃ��B

while ���Ɠ��l�ɁA������ _break, _continue ���߂��g�p�ł���B�܂��A�������� return �� goto ���g�p���Ă����Ȃ��B

;--------------------
%index
dict_iter_kv_end
dict_iter_kv �̏I�[
%inst
dict_iter_kv ����n�܂郋�[�v�̏I���������B

;--------------------
%index
dict_is_subset_of
�����������W�����H
%prm
(self, rhs)
self, rhs: ����
%inst
self �̂��ׂẴL�[�� rhs �̃L�[�ł�����A���̒l���^���܂߂ē������Ƃ��A�^��Ԃ��B

;--------------------
%index
dict_equals
���������������H
%prm
(self, rhs)
self, rhs: ����
%inst
self �� rhs �Ɋ܂܂��L�[�����ׂē������A����ɓ����L�[�ɑ΂���l���^���܂߂ē������Ƃ��A�^��Ԃ��B

;--------------------
dict_intersect_keys
�����̋��ʃL�[�̔z��
%prm
self, rhs, keys
self, rhs: ����
array keys: �L�[�̔z��ɂȂ�z��ϐ�
return: keys �̒���
%inst
keys ���Aself, rhs �̗����Ɋ܂܂��L�[����Ȃ�z��ɂ���B

;--------------------
%index
dict_copy_to_alist
�����̊e�v�f��A�z���X�g�ɕ���
%prm
self, keys, vals
array keys: �L�[���������܂��z��
array vals: �l���������܂��z��
return: dict_size(self)
%inst
�����Ɋ܂܂��e�L�[��z�� keys �ɃR�s�[���A�L�[ keys(i) �ɑΉ�����l�� vals(i) �ɃR�s�[����B

keys �͏����Ƃ͂�����Ȃ��B
%href
dict_chain_alist

;--------------------
%index
dict_chain_alist
�����ɘA�z���X�g��A��
%prm
self, keys, vals, len, conflict_policy
array keys: �L�[�̔z��
array vals: �l�̔z��
int len: keys, vals �̗v�f��
int conflict_policy
%inst
�e i = 0, 1, ..., len - 1 �ɂ��āAself �ɗv�f keys(i), vals(i) ��}������B

conflict_policy �́Aself �����łɑ}�������L�[���܂�ł���Ƃ��̏�����\���Bdict_chain ���Q�ƁB

keys �͏����łȂ��Ă������B
%href
dict_copy_to_alist
