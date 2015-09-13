#ifndef IG_ABDATA_PAIR_IMPL_AS
#define IG_ABDATA_PAIR_IMPL_AS

// ���傤��2�̗v�f����Ȃ�R���e�i
// 2�̗v�f�͂��ꂼ�� <lhs, rhs> �ƌĂсA�܂��A���ꂼ��� <[0], [1]> �Ƃ��� index ������U��B

#include "abelem.as"
#include "mod_pvalptr.as"
#include "mod_swap.as"

#module abdata_pair_impl mValue

#define true  1
#define false 0

//------------------------------------------------
// �v�f�� idx �l
//------------------------------------------------
#define global PairImplIdx_Lhs 0
#define global PairImplIdx_Rhs 1

//------------------------------------------------
// [i] �v�f��
//------------------------------------------------
#define global ctype pairImpl_size(%1)  2
#define global ctype pairImpl_empty(%1) 0
#define global pairImpl_length pairImpl_size

#define global pairImpl_new(%1, %2 = stt_zero@, %3 = stt_zero@) %tabdata %i0 %i0 \
	_cat(%p0,@__tmp) = %2 :\
	_cat(%p1,@__tmp) = %3 :\
	newmod %1, abdata_pair_impl@, _cat(%p0,@__tmp), _cat(%p1,@__tmp)  :\
	%o0 %o0 //

#define global pairImpl_delete(%1) delmod %1

//------------------------------------------------
// [i] �\�z
//------------------------------------------------
#modinit var lhs, var rhs
	abelem_new mValue, lhs
	abelem_new mValue, rhs
	return getaptr(thismod)
	
//------------------------------------------------
// �l�̎擾
//------------------------------------------------
#modfunc pairImpl_getv var vResult, int idx
	abelem_getv mValue(idx), vResult
	return
	
#modcfunc pairImpl_get int idx,  local tmp
	pairImpl_getv thismod, tmp, idx
	return tmp
	
#define global pairImpl_getv_lhs(%1,%2) pairImpl_getv %1, %2, PairImplIdx_Lhs
#define global pairImpl_getv_rhs(%1,%2) pairImpl_getv %1, %2, PairImplIdx_Rhs

#modfunc pairImpl_getv_both var vResultLhs, var vResultRhs
	pairImpl_getv_lhs thismod, vResultLhs
	pairImpl_getv_rhs thismod, vResultRhs
	return
	
#define global ctype pairImpl_get_lhs(%1) pairImpl_get(%1, PairImplIdx_Lhs)
#define global ctype pairImpl_get_rhs(%1) pairImpl_get(%1, PairImplIdx_Rhs)

//------------------------------------------------
// �N���[�������
//------------------------------------------------
#modfunc pairImpl_clone var vSrc, int idx
	abelem_clone mValue(idx), vSrc
	return
	
#define global pairImpl_clone_lhs(%1,%2) pairImpl_clone %1, %2, PairImplIdx_Lhs
#define global pairImpl_clone_rhs(%1,%2) pairImpl_clone %1, %2, PairImplIdx_Rhs

//------------------------------------------------
// �^�̎擾 ( �֐��`�� )
//------------------------------------------------
#modcfunc pairImpl_vartype int idx
	return abelem_vartype( mValue(idx) )
	
#define global ctype pairImpl_vartype_lhs(%1) pairImpl_vartype(%1, PairImplIdx_Lhs)
#define global ctype pairImpl_vartype_rhs(%1) pairImpl_vartype(%1, PairImplIdx_Rhs)

//------------------------------------------------
// �l�̐ݒ�
// 
// @ set    => �Е�
// @ assign => ����
//------------------------------------------------
#define global pairImpl_set(%1,%2,%3 = 0) %tabdata \
	_cat(%i,@__tmp) = (%2) :\
	pairImpl_setv %1, _cat(%o,@__tmp), %3
	
#modfunc pairImpl_setv var dst, int idx
	abelem_setv mValue(idx), dst
	return
	
#define global pairImpl_set_lhs(%1,%2) pairImpl_set %1, %2, PairImplIdx_Lhs
#define global pairImpl_set_rhs(%1,%2) pairImpl_set %1, %2, PairImplIdx_Rhs

#define global pairImpl_setv_lhs(%1,%2) pairImpl_setv %1, %2, PairImplIdx_Lhs
#define global pairImpl_setv_rhs(%1,%2) pairImpl_setv %1, %2, PairImplIdx_Rhs

#define global pairImpl_set_both(%1,%2,%3) %tabdata %i0 %i0 \
	_cat(%p0,@__tmp) = (%2) :\
	_cat(%p1,@__tmp) = (%3) :\
	pairImpl_setv_both %1, _cat(%p0,@__tmp), _cat(%p1,@__tmp) :\
	%o0 %o0 //

#modfunc pairImpl_setv_both var lhs, var rhs
	abelem_setv mValue(PairImplIdx_Lhs), lhs
	abelem_setv mValue(PairImplIdx_Rhs), rhs
	return
	
//------------------------------------------------
// �����グ
//------------------------------------------------
#modcfunc pairImpl_count var value,  local lhs, local rhs, local count
	pairImpl_clone_lhs thismod, lhs
	pairImpl_clone_rhs thismod, rhs
	if ( lhs == value ) { count ++ }
	if ( rhs == value ) { count ++ }
	return count

//------------------------------------------------
// �v�f����
// @ lhs �� rhs ����������
//------------------------------------------------
#modfunc pairImpl_loc_swap  local tmpLhs, local tmpRhs
	pairImpl_getv_lhs thismod, tmpLhs
	pairImpl_getv_rhs thismod, tmpRhs
	pairImpl_setv_lhs thismod, tmpRhs
	pairImpl_setv_rhs thismod, tmpLhs
	return
	
//------------------------------------------------
// [i] ���S����
//------------------------------------------------
#modfunc pairImpl_clear
	repeat pairImpl_size(thismod)
		abelem_delete mValue(cnt)
	loop
	repeat pairImpl_size(thismod)
		abelem_new mValue
	loop
	return
	
//------------------------------------------------
// [i] ����
//------------------------------------------------
#modfunc pairImpl_copy var src
	pairImpl_clear  thismod
	pairImpl_set_lhs thismod, pairImpl_get_lhs(src)
	pairImpl_set_rhs thismod, pairImpl_get_rhs(src)
	return
	
//------------------------------------------------
// [i] �A��
//------------------------------------------------
#define global pairImpl_chain(%1,%2) "pair_chain �͂ł��܂���B[pair_chain(%1, %2)]"

//------------------------------------------------
// [i] ����
//------------------------------------------------
#modfunc pairImpl_swap var rhs
	pairImpl_swap_impl@abdata_pair_impl rhs, mValue
	return
	
#modfunc pairImpl_swap_impl@abdata_pair_impl array lhs_value
	swap_array lhs_value, mValue
	return
	
//------------------------------------------------
// ��������r
//------------------------------------------------
#modcfunc pairImpl_lexicographical_compare var rhs
	return pairImpl_lexicographical_compare_impl@abdata_pair_impl(rhs, mValue)

#modcfunc pairImpl_lexicographical_compare_impl@abdata_pair_impl array lhs_value, \
	local cmp
	
	assert pairImpl_size(thismod) == 2
	repeat 2
		cmp = abelem_cmp(lhs_value(cnt), mValue(cnt))
		if ( cmp ) { break }
	loop
	return cmp
	
//------------------------------------------------
// [i] �����q::������
//------------------------------------------------
#modfunc pairImpl_iter_init var iterData
	iterData = -1
	return
	
//------------------------------------------------
// [i] �����q::�X�V
//------------------------------------------------
#modcfunc pairImpl_iter_next var vIt, var iterData
	iterData ++
	
	if ( 0 <= iterData && iterData < pairImpl_size(thismod) ) {
		pairImpl_getv thismod, vIt, iterData
		return true
	} else {
		return false
	}
	
#ifdef _DEBUG

//------------------------------------------------
// �f�o�b�O�o��
//------------------------------------------------
#define global pairImpl_dbglog(%1) pairImpl_dbglog_ %1, "%1"

#modfunc pairImpl_dbglog_ str _ident,  local ident, local lhs, local rhs
	ident = _ident
	pairImpl_getv_both thismod, lhs, rhs
	logmes "pair " + strtrim(ident, 0, ' ') + " = <" + lhs + ", " + rhs + ">\n"
	return
	
#else //defined(_DEBUG)

#define global pairImpl_dbglog(%1) :

#endif //defined(_DEBUG)
	
#global

#endif
