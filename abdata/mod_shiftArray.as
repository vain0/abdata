// �z��V�t�g���W���[��

#ifndef IG_MODULE_SHIFT_ARRAY_AS
#define IG_MODULE_SHIFT_ARRAY_AS

#module shift_array_mod

#define true 1
#define false 0
#define global stdarray_index_of_end (-127)

//------------------------------------------------
// �z���Ԃ̐��K��
// @private
//------------------------------------------------
#deffunc stdarray_regularize_range@shift_array_mod array self, array range,  local tmp
	if ( range(1) == stdarray_index_of_end ) { range(1) = length(self) }
	if ( range(0) > range(1) ) {
		range(0) = range(1)
	}
	return
	
//------------------------------------------------
// �}�� ( �I�ȏ��� )
//------------------------------------------------
#deffunc stdarray_insert_room array self, int idx,  local i
	
	// �}�������ꏊ���󂯂�
	for i, length(self), idx, -1
		self(i) = self(i - 1)
	next
	
	return
	
//------------------------------------------------
// �폜 ( �I�ȏ��� )
//------------------------------------------------
#deffunc stdarray_erase array self, int idx,  local i
	
	// �폜�����ꏊ������ ( ���̒l�ŏ㏑������ )
	for i, idx, length(self) - 1
		self(i) = self(i + 1)
	next
	
	return
	
//------------------------------------------------
// �ړ�
//------------------------------------------------
#deffunc stdarray_loc_move array self, int from, int to,  local temp, local dir, local i
	if ( from == to ) { return }
	
	// �ړ����̒l��ۑ�����
	temp = self(from)
	
	// �ړ�����
	if ( from > to ) {
		dir = -1				// ��ɐi�ނȂ� -1
	} else {
		dir = 1
	}
	for i, from, to, dir
		self(i) = self(i + dir)	// ���̏ꏊ�̒l���󂯎��
	next
	self(to) = temp
	
	return
	
//------------------------------------------------
// ����
//------------------------------------------------
#deffunc stdarray_loc_swap array self, int pos1, int pos2,  local temp
	if ( pos1 == pos2 ) { return }
	temp       = self(pos1)
	self(pos1) = self(pos2)
	self(pos2) = temp
	return
	
//------------------------------------------------
// ����
// 
// @prm self
// @prm step         : �������
// @prm [iBgn, iEnd) : ����Ώۂ̋��
//------------------------------------------------
#deffunc stdarray_rotate_step array self, int iBgn, int iEnd, int dir,  local range
	range = iBgn, iEnd
	stdarray_regularize_range self, range
	
	if ( dir >= 0 ) {
		stdarray_loc_move self, range(0), range(1) - 1
	} else {
		stdarray_loc_move self,           range(1) - 1, range(0)
	}
	return
	
// �t��]
#define global stdarray_rotate(    %1, %2 = 0, %3 = stdarray_index_of_end) stdarray_rotate_step %1, %2, %3,  1
#define global stdarray_rotateBack(%1, %2 = 0, %3 = stdarray_index_of_end) stdarray_rotate_step %1, %2, %3, -1

//------------------------------------------------
// ���]
// 
// @prm this
// @prm [iBgn, iEnd) : ���]�Ώۂ̋��
//------------------------------------------------
#define global stdarray_reverse(%1, %2 = 0, %3 = stdarray_index_of_end) stdarray_reverse_ %1, %2, %3
#deffunc stdarray_reverse_ array self, int iBgn, int iEnd,  local range
	range = iBgn, iEnd
	stdarray_regularize_range self, range
	
	repeat (range(1) - range(0)) / 2
		stdarray_loc_swap self, range(0) + cnt, range(1) - cnt - 1
	loop
	
	return
	
#global

#endif
