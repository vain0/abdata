#ifndef IG_ABDATA_CONTAINER_IMPL_AS
#define IG_ABDATA_CONTAINER_IMPL_AS

#include "abheader.as"
#include "abelem.as"
#include "mod_shiftArray.as"
#include "mod_pvalptr.as"
#include "mod_swap.as"
#include "mod_ref.as"

#module abdata_con_impl mCnt, mElems, midlist
; abdata_container_impl �͎��ʎq���̌��E�𒴂��Ă��邽��

#define ctype ARG_TEMP(%1) con_impl_argtmp_%1@__abdata

#define ctype numrg(%1,%2,%3) ( ((%2) <= (%1)) && ((%1) <= (%3)) )
#define true  1
#define false 0
#define int_max 0x7FFFFFFF

#define ctype STR_ERR_OVER_RANGE(%1) "Error! [abdata �R���e�i] �v�f�ԍ��͈͊O�G���[(" + (%1) + ")"

#enum global SortMode_Ascending = 0
#enum global SortMode_Decending = 1

#define global containerImpl_new(%1, %2 = 0, %3 = stt_zero@) newmod %1, abdata_con_impl@, %2, %3
#define global containerImpl_delete(%1) delmod %1

//------------------------------------------------
// [i] �\�z
// 
// @prm num      : num �̗v�f�����Ɋm�ۂ�����ԂŐ�������B
// @prm vDefault : �m�ۂ���l�̏����l
//------------------------------------------------
#modinit int num, var vDefault
	if ( num <= 0 ) {
		dimtype mElems, 5
		
	} else {
		repeat num
			abelem_new mElems, vDefault
			midlist(cnt) = cnt
			mCnt ++
		loop
	}
	
	return getaptr(thismod)
	
//------------------------------------------------
// �l�̎擾 ( ���ߌ`�� )
//------------------------------------------------
#modfunc containerImpl_getv_ var result, int _i, int bRemove,  local i
	
	i = containerImpl_getRealIndex(thismod, _i)
	
	abelem_getv mElems( midlist(i) ), result
	
	if ( bRemove ) {
		containerImpl_erase thismod, i
	}
	
	return
	
#define global containerImpl_getv(%1,%2,%3=0) containerImpl_getv_ %1, %2, %3, 0
#define global containerImpl_popv(%1,%2,%3=0) containerImpl_getv_ %1, %2, %3, 1

//------------------------------------------------
// �l�̎擾 ( �֐��`�� )
//------------------------------------------------
#modcfunc containerImpl_get_ int i, int bRemove,  local tmp
	containerImpl_getv_ thismod, tmp, i, bRemove
	return tmp
	
#define global ctype containerImpl_get(%1,%2=0) containerImpl_get_(%1, %2, 0)
#define global ctype containerImpl_pop(%1,%2=0) containerImpl_get_(%1, %2, 1)

//------------------------------------------------
// �Q�Ɖ� ( ���ߌ`�� )
//------------------------------------------------
#modfunc containerImpl_clone var vRef, int i
	abelem_clone mElems( midlist( containerImpl_getRealIndex(thismod, i) ) ), vRef
	return
	
#modfunc containerImpl_clone_abelem var ref, int i
	dup ref, mElems(midlist(i))
	return
	
//------------------------------------------------
// �Q�Ɖ� ( �֐��`�� )
//------------------------------------------------
#define global ctype containerImpl_ref(%1, %2) \
	ref_ref_expr_template_2(containerImpl_ref_, %1, %2)

#modcfunc containerImpl_ref_ array ref, int i
	containerImpl_clone thismod, ref, i
	return 0
	
//------------------------------------------------
// �擪�E�����̒l�̎擾
// 
// @ get ���� >> const �ȑ���
// @ pop ���� >> �v�f�͎�菜�����
//------------------------------------------------
#define global ctype containerImpl_get_front(%1)     containerImpl_get(%1, 0)
#define global ctype containerImpl_get_back(%1)      containerImpl_get(%1, -1)
#define global       containerImpl_getv_front(%1,%2) containerImpl_getv %1, %2, 0
#define global       containerImpl_getv_back(%1,%2)  containerImpl_getv %1, %2, -1
#define global ctype containerImpl_pop_front(%1)     containerImpl_pop(%1, 0)
#define global ctype containerImpl_pop_back(%1)      containerImpl_pop(%1, -1)
#define global       containerImpl_popv_front(%1,%2) containerImpl_popv %1, %2, 0
#define global       containerImpl_popv_back(%1,%2)  containerImpl_popv %1, %2, -1

//------------------------------------------------
// �^�̎擾 ( �֐��`�� )
//------------------------------------------------
#modcfunc containerImpl_vartype int i
	return abelem_vartype( mElems(midlist(containerImpl_getRealIndex(thismod, i))) )
	
#define global ctype containerImpl_vartype_front(%1) containerImpl_vartype(%1, 0)
#define global ctype containerImpl_vartype_back(%1)  containerImpl_vartype(%1, -1)

//------------------------------------------------
// �l�̐ݒ�
//------------------------------------------------
#define global containerImpl_set(%1,%2,%3=0) ARG_TEMP@abdata_con_impl(set) = %2 : containerImpl_setv %1, ARG_TEMP@abdata_con_impl(set), %3
#modfunc containerImpl_setv var vValue, int i,  local iv
	
	iv = midlist( containerImpl_getRealIndex(thismod, i) )
	
	// �K�؂Ɍ^��ϊ�����
	abelem_changeVartype mElems(iv), vartype(vValue)
	
	abelem_setv mElems( iv ), vValue
	
	return
	
//------------------------------------------------
// �}��
// 
// @permit (i == mCnt) : �Ō���ւ̒ǉ��̂���
// @ i ���͈͊O => {
// @	( i <     0 ) => i += mCnt,
// @	( i >= mCnt ) => ([i] �܂ŗv�f�������g��)
// @ };
//------------------------------------------------
#define global containerImpl_insert(%1,%2,%3=0) ARG_TEMP@abdata_con_impl(insert) = %2 : containerImpl_insertv %1, ARG_TEMP@abdata_con_impl(insert), %3
#modfunc containerImpl_insertv var vValue, int _i,  local i, local id
	i = _i
	if ( _i < 0 ) {
		i += mCnt
	} else : if ( _i > mCnt ) {
		logmes "abdata �v�f�������g�� [" + mCnt + ", " + _i + "]"
		repeat _i - mCnt, mCnt
			containerImpl_insertv thismod, stt_zero@, cnt
		loop
		i = _i
	} else {
		i = _i
	}
	
	// i �Ԗڂ��󂯂�
	stdarray_insert_room midlist, i
	
	// �V�K�l��ǉ�
;	id         = GetNextAddIndex( mElems )
	abelem_new mElems, vValue
	midlist(i) = stat	;id
	mCnt ++
	
	return
	
//------------------------------------------------
// �v�f�̔{��
//------------------------------------------------
#modfunc containerImpl_double int _i,  local i, local temp
	i = containerImpl_getRealIndex( thismod, _i )
	
	containerImpl_getv    thismod, temp, i
	containerImpl_insertv thismod, temp, i
	return
	
//------------------------------------------------
// �擪�E�Ō���ւ̒ǉ�
//------------------------------------------------
#define global containerImpl_double_front(%1)   containerImpl_double  %1, 0
#define global containerImpl_double_back(%1)    containerImpl_double  %1, (-1)
#define global containerImpl_push_front(%1,%2)  containerImpl_insert  %1, %2, 0
#define global containerImpl_pushv_front(%1,%2) containerImpl_insertv %1, %2, 0
#define global containerImpl_push_back(%1,%2)   containerImpl_insert  %1, %2, containerImpl_size(%1)
#define global containerImpl_pushv_back(%1,%2)  containerImpl_insertv %1, %2, containerImpl_size(%1)
#define global containerImpl_push               containerImpl_push_back
#define global containerImpl_pushv              containerImpl_pushv_back
#define global containerImpl_add                containerImpl_push_back

//------------------------------------------------
// ����
//------------------------------------------------
#modfunc containerImpl_erase int _i,  local i
	i = containerImpl_getRealIndex(thismod, _i)
	containerImpl_erase_range thismod, i, i + 1
	return
	
#define global containerImpl_erase_front(%1) containerImpl_erase %1, 0
#define global containerImpl_erase_back(%1)  containerImpl_erase %1, (-1)

#modfunc containerImpl_erase_range int lb, int ub
	if ( ub <= lb ) { return }
	repeat mCnt - ub, lb
		if ( cnt < ub ) {
			abelem_delete mElems(midlist(cnt))
		}
		midlist(cnt) = midlist(cnt + (ub - lb))
	loop
	mCnt -= (ub - lb)
	return
	
//------------------------------------------------
// �v�f���̐ݒ�
// 
// @result: ���̗v�f��
//------------------------------------------------
#define global containerImpl_resize(%1, %2, %3) \
	containerImpl_resize_ (%1), (%2), (%3)

#modfunc containerImpl_resize_ int newlen, var initValue,  local dif
	dif = newlen - mCnt
	
	// ����
	if ( dif < 0 ) {
		if ( newlen <= 0 ) {
			containerImpl_clear thismod
			
		} else {
			// �v�f [newlen] �ȍ~������
			repeat -dif, newlen
				abelem_delete mElems( midlist(cnt) )
				midlist(cnt) = -1		// �����v�f�ɂ���
			loop
		}
		
	// ����
	} else : if ( dif > 0 ) {
		// �V�v�f�� dif �������A�����ɒǉ�����
		repeat dif, newlen - dif
			abelem_new mElems, initValue
			midlist(cnt) = stat	;id
		loop
	}
	
	mCnt = newlen
	return newlen - dif
	
//------------------------------------------------
// �ړ�
//------------------------------------------------
#modfunc containerImpl_loc_move int iSrc, int iDst
	abAssert ( containerImpl_size(thismod) >= 2 ), "move �ɂ͏��Ȃ��Ƃ�2�v�f���K�v"		// �Œ�ł�2�̗v�f���Ȃ��ƁAmove �͈Ӗ����Ȃ�
	
	stdarray_loc_move midlist, containerImpl_getRealIndex(thismod, iSrc), containerImpl_getRealIndex(thismod, iDst)
	return
	
//------------------------------------------------
// ����
//------------------------------------------------
#modfunc containerImpl_loc_swap int iPos1, int iPos2
	abAssert ( containerImpl_size(thismod) >= 2 ), "swap �ɂ͏��Ȃ��Ƃ�2�v�f���K�v"		// �Œ�ł�2�̗v�f���Ȃ��ƁAswap �͈Ӗ����Ȃ�
	
	stdarray_loc_swap midlist, containerImpl_getRealIndex(thismod, iPos1), containerImpl_getRealIndex(thismod, iPos2)
	return
	
#define global containerImpl_loc_swap_front(%1) containerImpl_loc_swap %1,  0,  1
#define global containerImpl_loc_swap_back(%1)  containerImpl_loc_swap %1, -2, -1

//------------------------------------------------
// ����
//------------------------------------------------
#modfunc containerImpl_rotateImpl int iBgn, int _iEnd, int dir,  local iEnd
	if ( _iEnd == stdarray_index_of_end ) { iEnd = containerImpl_size(thismod) } else { iEnd = _iEnd }
	stdarray_rotate_step midlist, iBgn, iEnd, dir
	return
	
#define global containerImpl_rotate(     %1, %2 = 0, %3 = stdarray_index_of_end) containerImpl_rotateImpl %1, %2, %3,  1
#define global containerImpl_rotate_back(%1, %2 = 0, %3 = stdarray_index_of_end) containerImpl_rotateImpl %1, %2, %3, -1

//------------------------------------------------
// ���]
//------------------------------------------------
#define global containerImpl_reverse(%1, %2 = 0, %3 = stdarray_index_of_end) containerImpl_reverse_ %1, %2, %3
#modfunc containerImpl_reverse_ int iBgn, int _iEnd,  local iEnd
	if ( _iEnd == stdarray_index_of_end ) { iEnd = containerImpl_size(thismod) } else { iEnd = _iEnd }
	stdarray_reverse midlist, iBgn, iEnd
	return
	
//------------------------------------------------
// [i] ���S����
//------------------------------------------------
#modfunc containerImpl_clear
	
	// �S�v�f���������
	foreach mElems
		abelem_delete mElems(cnt)
	loop
	
	// �ԍ����X�g��������
	dim midlist
	mCnt = 0
	
	return
	
//------------------------------------------------
// [i] �A��
//------------------------------------------------
#modfunc containerImpl_chain var src,  local tmp, local offset
	offset = mCnt
 	repeat containerImpl_size( src )
		containerImpl_getv       src, tmp, cnt
		containerImpl_insert thismod, tmp, cnt + offset
	loop
	return
	
//------------------------------------------------
// [i] ����
//------------------------------------------------
#modfunc containerImpl_copy var src
	containerImpl_clear thismod
	containerImpl_chain thismod, src
	return
	
//------------------------------------------------
// [i] ����
//------------------------------------------------
#modfunc containerImpl_swap var rhs
	containerImpl_swap_impl@abdata_con_impl rhs, mCnt, mElems, midlist
	return
	
#modfunc containerImpl_swap_impl@abdata_con_impl array lhs_cnt, array lhs_elems, array lhs_idlist
	swap_int   mCnt,    lhs_cnt
	swap_array mElems,  lhs_elems
	swap_array midlist, lhs_idlist
	return
	
//------------------------------------------------
// ��������r
//------------------------------------------------
#modcfunc containerImpl_lexicographical_compare var rhs
	return containerImpl_lexicographical_compare_impl@abdata_con_impl(rhs, mCnt, mElems, midlist)
	
#modcfunc containerImpl_lexicographical_compare_impl@abdata_con_impl int lhs_size, array lhs_elems, array lhs_idlist, \
	local cmp
	
	if ( lhs_size != mCnt ) {
		return lhs_size - mCnt
	}
	repeat lhs_size
		cmp = abelem_cmp(lhs_elems(lhs_idlist(cnt)), mElems(midlist(cnt)))
		if ( cmp != 0 ) { break }
	loop
	return cmp
	
//------------------------------------------------
// ����
// 
// @alg: (based: Merge-Sort)
// @	1. �^�^�C�v�l�Ő���
// @	2. �����^ => �s�����ɂ���r�Ő���
// @prm mode : SortMode_* (default: SortMode_Ascening)
//------------------------------------------------
#modfunc containerImpl_sort int mode,  \
	local arrTmp, local arrDst, local len, \
	local p, local p1, local e1, local p2, local e2, local sizeSegment, local sizeSegMerged, \
	local cmp
	
	len = containerImpl_size(thismod)
	dim     arrDst, len
	foreach arrDst
		arrDst(cnt) = cnt
	loop
	
	dim arrTmp, len
	
	// �}�[�W�\�[�g
	repeat
		sizeSegment = 1 << cnt		// 1, 2, 4, 8, ...
		
		// 2-Segment ���ƂɃ}�[�W
		repeat
			p  = sizeSegment * (cnt * 2)	// 2-Segment �̐擪
			p1 = p							// lhs (left hand segment) �͈� (�擪�v�f)
			e1 = p1 + sizeSegment			// �V (�ŏI�v�f + 1)
			p2 = e1							// rhs
			e2 = limit( p2 + sizeSegment, 0, len )
			sizeSegMerged = (e2 - p)		// �}�[�W��� Segment �T�C�Y
			
			if ( sizeSegMerged < sizeSegment ) { break }	// 臒l�ȉ� => �}�[�W�����I��
			
			repeat sizeSegMerged
				if ( p2 >= e2 ) {			// rhs �̎��o�������Ɋ������Ă���
					arrTmp(cnt) = arrDst(p1) : p1 ++
				} else : if ( p1 >= e1 ) {	// lhs �V
					arrTmp(cnt) = arrDst(p2) : p2 ++
				} else {
					// ?( ��v���� or ( ����������(�^) ����(�^) || �E��������(�U) �~��(�U) ) ) => lhs ����Ƃ�
					cmp = abelem_cmp( mElems(arrDst(p1)), mElems(arrDst(p2)) )
					if ( cmp == 0 || ( (cmp < 0) == (mode == SortMode_Ascending) ) ) {
						arrTmp(cnt) = arrDst(p1) : p1 ++
					} else {
						arrTmp(cnt) = arrDst(p2) : p2 ++
					}
				}
			loop
			
			// �}�[�W���ꂽ�z����\�[�X�z��ɓ\��t��
			memcpy arrDst(p), arrTmp, sizeSegMerged * 4
		loop
		
		// �}�[�W�I�� (1�� Segment �ɓZ�܂�������)
		if ( len <= sizeSegment ) { break }
	loop
	
	// idx-list ��ύX
	memcpy midlist, arrDst, len * 4
	
	return
	
//------------------------------------------------
// ����ς݂��H
//------------------------------------------------
#modcfunc containerImpl_is_sorted int sort_mode,  local is_sorted,  local clone1, local clone2
	is_sorted = true
	repeat limit(0, mCnt - 1, int_max)
		containerImpl_clone thismod, clone1, cnt
		containerImpl_clone thismod, clone2, cnt + 1
		if ( opCompare(clone1, clone2) * (1 - 2 * sort_mode) > 0 ) {
			is_sorted = false : break
		}
	loop
	return is_sorted
	
//------------------------------------------------
// ����ς݃R���e�i�́A���E�E��E���݂���
//------------------------------------------------
#modcfunc containerImpl_lu_bound_@abdata_con_impl var value, int sort_mode, int finds_upper, \
	local lb, local ub, local mid, local mid_clone, local cmp
	
	assert containerImpl_is_sorted(thismod, sort_mode)
	lb = -1 : ub = mCnt
	repeat
		if ( (ub - lb) <= 1 ) { break }
		mid = lb + (ub - lb) / 2
		containerImpl_clone thismod, mid_clone, mid
		
		cmp = opCompare(mid_clone, value) * (1 - 2 * sort_mode)
		if ( ((finds_upper != 0) && cmp == 0) || cmp < 0 ) {
			lb = mid
		} else {
			ub = mid
		}
	loop
	return ub
	
#define global ctype containerImpl_lower_bound(%1, %2, %3 = SortMode_Ascending) containerImpl_lu_bound_@abdata_con_impl((%1), (%2), (%3), 0)
#define global ctype containerImpl_upper_bound(%1, %2, %3 = SortMode_Ascending) containerImpl_lu_bound_@abdata_con_impl((%1), (%2), (%3), 1)

#modfunc containerImpl_equal_range var value, var lb, var ub, int sort_mode
	lb = containerImpl_lower_bound(thismod, value, sort_mode)
	ub = containerImpl_upper_bound(thismod, value, sort_mode)
	return
	
//------------------------------------------------
// ����ς݃R���e�i�́A�K�؂Ȉʒu�ɗv�f��}������
//
// @param value: �}�������v�f�̒l
// @param can_dup (true):
// ���ꂪ�^�Ȃ�A���ł� value ���܂܂�Ă���Ƃ����A�}������B
//------------------------------------------------
#define global containerImpl_sorted_insertv(%1, %2, %3 = true@abdata_con_impl, %4 = SortMode_Ascending) \
	containerImpl_sorted_insertv_@abdata_con_impl (%1), (%2), (%3), (%4)

#modfunc containerImpl_sorted_insertv_@abdata_con_impl \
	var value, int can_dup, int sort_mode,  \
	local lb, local clone
	
	lb = containerImpl_lower_bound(thismod, value, sort_mode)
	if ( can_dup == false && lb != containerImpl_size(thismod) ) {
		containerImpl_clone thismod, clone, lb
		if ( opCompare(clone, value) == 0 ) { return }
	}
	containerImpl_insertv thismod, value, lb
	return
	
//------------------------------------------------
// ����ς݃R���e�i����A�v�f����������
//
// @param value: �������ׂ��v�f�̒l
// @param max_count (��): ���������v�f�̌��̍ő�l
//------------------------------------------------
#define global containerImpl_sorted_erasev(%1, %2, %3 = int_max@abdata_con_impl, %4 = SortMode_Ascending) \
	containerImpl_sorted_erasev_@abdata_con_impl (%1), (%2), (%3), (%4)
	
#modfunc containerImpl_sorted_erasev_@abdata_con_impl \
	var value, int max_count, int sort_mode,  \
	local lb, local ub
	
	containerImpl_equal_range thismod, value, lb, ub, sort_mode
	ub = lb + limit(ub - lb, 0, max_count)
	containerImpl_erase_range thismod, lb, ub
	return
	
//------------------------------------------------
// [i] �����q::������
//------------------------------------------------
#modfunc containerImpl_iter_init var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] �����q::�X�V
//------------------------------------------------
#modcfunc containerImpl_iter_next var vIt, var iterData
	iterData ++
	
	if ( containerImpl_is_valid(thismod, iterData) == false ) {
		return false
	}
	
	containerImpl_getv thismod, vIt, iterData
	return true
	
//------------------------------------------------
// [i] �v�f��
//------------------------------------------------
#modcfunc containerImpl_size
	return mCnt
	
#define global containerImpl_length containerImpl_size
#define global ctype containerImpl_empty(%1) ( containerImpl_size(%1) == 0 )

//------------------------------------------------
// �����グ
//------------------------------------------------
#modcfunc containerImpl_count var value,  local count, local ref
	repeat mCnt
		containerImpl_clone thismod, ref, cnt
		if ( ref == value ) { count ++ }
	loop
	return count

//------------------------------------------------
// �͈̓`�F�b�N
//------------------------------------------------
#modcfunc containerImpl_is_valid int i
	if ( numrg(i, 0, mCnt - 1) ) {					// �L���͈͂�
		if ( varuse( mElems(midlist(i)) ) ) {		// �L���ȗv�f�ԍ���
			return true
		}
	}
	return false
	
//------------------------------------------------
// ���ۂ̗v�f�ԍ��𓾂�
// @private
//------------------------------------------------
#modcfunc containerImpl_getRealIndex@abdata_con_impl int _i,  local i
	i = _i
	
	// �z�Q��
	if ( i < 0 ) {
		i += mCnt
	}
	
	abAssert ( 0 <= i && i < mCnt ), STR_ERR_OVER_RANGE(i)
	
	return i
	
#ifdef _DEBUG

//------------------------------------------------
// �f�o�b�O�o��
//------------------------------------------------
#define global containerImpl_dbglog(%1) containerImpl_dbglog_ %1, "%1"

#modfunc containerImpl_dbglog_ str _ident,  local ident
	ident = _ident
	
	logmes "["+ strtrim(ident, 0, ' ') +"] debug-log"
	
	repeat containerImpl_size(thismod)
		logmes strf("#%2d: ", cnt) + containerImpl_get(thismod, cnt)
	loop
	
	logmes ""
	return
	
#else //defined(_DEBUG)

#define global containerImpl_dbglog(%1) :

#endif //defined(_DEBUG)
	
#global

#endif
