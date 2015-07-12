#ifndef IG_ABDATA_ARRAY_LEN_AS
#define IG_ABDATA_ARRAY_LEN_AS

// �����w�����1�����W���z��

#include "mod_opCompare.as"

#module arrayLen

#define true 1
#define false 0
#define int_max 0x7FFFFFFF
	
#defcfunc arrayLen_is_valid_len array self, int len
	return (0 <= len && len <= length(self))
	
/**
* arrayLen �̏���
//*/
#deffunc arrayLen_clear array self, var len
	dim self
	len = 0
	return
	
/**
* arrayLen �̕���
//*/
#deffunc arrayLen_copy array self, var len, array target, int target_len
	arrayLen_clear self, len
	arrayLen_chain self, len, target, target_len
	return
	
/**
* arrayLen �̘A��
//*/
#deffunc arrayLen_chain array self, var len, array target, int target_len
	repeat target_len
		self(len + cnt) = target(cnt)
	loop
	len += target_len
	return
	
/**
* arrayLen �̌���
//*/
#deffunc arrayLen_swap array self, var len, array target, var target_len, \
	local tmp, local tmp_len
	
	arrayLen_copy tmp, tmp_len,       self, len
	arrayLen_copy self, len,          target, target_len
	arrayLen_copy target, target_len, tmp, tmp_len
	return
	
/**
* arrayLen �́Aidx �Ԗڂ��󂯂� (�������Ȃ�)
//*/
#deffunc arrayLen_insert_no_init array self, var len, int idx
	assert arrayLen_is_valid_len(self, len)
	assert idx >= 0
	if( idx < len ) {
		repeat len - idx
			self(len - cnt) = self(len - cnt - 1)
		loop
		len ++
	} else {
		self(idx) = self(0)
		len += idx - len + 1
	}
	return
	
/**
* arrayLen �́A[lb, ub) �Ԗڂ̗v�f����������
//*/
#deffunc arrayLen_erase_range array self, var len, int lb, int ub
	assert arrayLen_is_valid_len(self, len)
	assert 0 <= lb && lb <= len
	assert 0 <= ub && ub <= len
	repeat len - ub
		self(lb + cnt) = self(ub + cnt)
	loop
	len -= ub - lb
	return
	
/**
* arrayLen ���A�����ɐ���ς݂ł��邩�ۂ�
*
* �܂� self(0) <= self(1) <= ... �ƂȂ��Ă��邱�ƁB
*
* @param self: �Ώۂ̔z��
* @param len: self �̒���
//*/
#defcfunc arrayLen_is_sorted array self, int len,  local is_sorted
	assert arrayLen_is_valid_len(self, len)
	is_sorted = true
	repeat limit(0, len - 1, int_max)
		if ( opCompare(self(cnt), self(cnt + 1)) > 0 ) {
			is_sorted = false : break
		}
	loop
	return is_sorted
	
/**
* ����ς� arrayLen �́A���E���݂���
*
* @param self: �Ώۂ̔z��
* @param len: self �̒���
* @param value: �T���l
* @return i:
*	���� self(i) == value �ƂȂ�v�f������΁A���̍ŏ��� i ���Ԃ�B
*	���ꂪ�Ȃ���΁Aself(i) > value �ƂȂ�ŏ��� i ���Ԃ�B
*	������Ȃ���΁Alen ���Ԃ�B
//*/
#defcfunc arrayLen_lower_bound array self, int len, var value, \
	local lb, local ub, local mid, local cmp
	
	assert arrayLen_is_sorted(self, len)
	
	lb = -1 : ub = len
	repeat
		if ( (ub - lb) <= 1 ) { break }
		mid = lb + (ub - lb) / 2
		if ( opCompare(self(mid), value) < 0 ) {
			lb = mid
		} else {
			ub = mid
		}
	loop
	return ub
	
/**
* ����ς� arrayLen �́A��E���݂���
*
* @param value: �T���l
* @return i:
*	self(k) > value �ƂȂ�v�f������΁A���̂悤�� k �̍ŏ��l���Ԃ�B
*	�Ȃ���΁Alen ���Ԃ�B
//*/
#defcfunc arrayLen_upper_bound array self, int len, var value, \
	local lb, local ub, local mid, local cmp
	
	assert arrayLen_is_sorted(self, len)
	
	lb = -1 : ub = len
	repeat
		if ( (ub - lb) <= 1 ) { break }
		mid = lb + (ub - lb) / 2
		if ( opCompare(self(mid), value) <= 0 ) {
			lb = mid
		} else {
			ub = mid
		}
	loop
	return ub
	
/**
* ����ς� arrayLen �́A����l���܂ދ�Ԃ��݂���
*
* �u(lb <= k && k < ub) ���݂������ׂĂ� k �ɂ��āAself(k) == value�v�ƂȂ�悤�ȁAlb, ub ���݂���B
*
* @param value: �T���l
* @param lb, ub
*	arrayLen_lower_bound, _upper_bound �̒l����������B
//*/
#deffunc arrayLen_equal_range array self, int len, var value, var lb, var ub
	lb = arrayLen_lower_bound(self, len, value)
	ub = arrayLen_upper_bound(self, len, value)
	return
	
/**
* ����ς� arrayLen ���܂ށA����l�̌���Ԃ�
*
* @param value: �T���l
//*/
#defcfunc arrayLenSorted_count array self, int len, var value,  local lb, local ub
	lb = arrayLen_lower_bound(self, len, value)
	if ( lb != len ) : if ( self(lb) == value ) {
		ub = arrayLen_upper_bound(self, len, value)
		return ub - lb
	}
	return 0
	
/**
* ����ς� arrayLen �́A�K�؂Ȉʒu�ɗv�f��}������
*
* @param value: �}�������v�f�̒l
* @param can_dup (true):
*	���ꂪ�^�Ȃ�A���ł� value ���܂܂�Ă���Ƃ����A�}������B
* @return n:
*	�}�����ꂽ�v�f�̌�
//*/
#define global arrayLenSorted_insert_v(%1, %2, %3, %4 = true@arrayLen) \
	_arrayLenSorted_insert_v@arrayLen (%1), (%2), (%3), (%4)

#deffunc _arrayLenSorted_insert_v@arrayLen \
	array self, var len, var value, int can_dup,  local lb
	
	lb = arrayLen_lower_bound(self, len, value)
	if ( can_dup == false && lb != len ) {
		if ( self(lb) == value ) { return 0 }
	}
	arrayLen_insert_no_init self, len, lb
	self(lb) = value
	return 1
	
/**
* ����ς� arrayLen ����A�v�f����������
*
* @param value: �������ׂ��v�f�̒l
* @param max_count (��): ���������v�f�̌��̍ő�l
* @return n:
*	�������ꂽ�v�f�̌�
//*/
#define global arrayLenSorted_erase_v(%1, %2, %3, %4 = int_max@arrayLen) \
	_arrayLenSorted_erase_v@arrayLen (%1), (%2), (%3), (%4)
	
#deffunc _arrayLenSorted_erase_v@arrayLen \
	array self, var len, var value, int max_count,  local ran
	
	arrayLen_equal_range self, len, value, ran(0), ran(1)
	ran(1) = ran(0) + limit(ran(1) - ran(0), 0, max_count)
	arrayLen_erase_range self, len, ran(0), ran(1)
	return ran(1) - ran(0)
	
#global

#endif