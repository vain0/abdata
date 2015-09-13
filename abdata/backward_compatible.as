#ifndef        IG_ABDATA_BACKWARD_COMPATIBLE_AS
#define global IG_ABDATA_BACKWARD_COMPATIBLE_AS

/*
���̃t�@�C���� include ���邱�ƂŁA�Â� abdata �̃R�}���h���g�p�ł���B
�������ȉ��̃R�}���h�͋������ύX���ꂽ���߁A���̃t�@�C���ł͑Ώ�����Ȃ��B

`*_swap`: ���݂̓R���e�i�̒��g����������R�}���h�B�Â����̂� `*_loc_swap` �ɉ������ꂽ�B
`*_count`: ���݂͂���l�����v�f�̌��𐔂���R�}���h�B�Â����̂� `*_size` ���g���B
//*/

#define global dequeNull            abdataNull
#define global deque_make           container_make
#define global deque_new            container_new
#define global deque_delete         container_delete
#define global deque_getv           container_getv
#define global deque_popv           container_popv
#define global deque_get            container_get
#define global deque_pop            container_pop
#define global deque_clone          container_clone
#define global deque_ref            container_ref
#define global deque_get_front      container_get_front
#define global deque_get_back       container_get_back
#define global deque_getv_front     container_getv_front
#define global deque_getv_back      container_getv_back
#define global deque_pop_front      container_pop_front
#define global deque_pop_back       container_pop_back
#define global deque_popv_front     container_popv_front
#define global deque_popv_back      container_popv_back
#define global deque_vartype        container_vartype
#define global deque_vartype_front  container_vartype_front
#define global deque_vartype_back   container_vartype_back
#define global deque_set            container_set
#define global deque_setv           container_setv
#define global deque_insert         container_insert
#define global deque_insertv        container_insertv
#define global deque_double_front   container_double_front
#define global deque_double_back    container_double_back
#define global deque_push_front     container_push_front
#define global deque_push_back      container_push_back
#define global deque_pushv_front    container_pushv_front
#define global deque_pushv_back     container_pushv_back
#define global deque_push           container_push
#define global deque_pushv          container_pushv
#define global deque_add            container_add
#define global deque_erase          container_erase
#define global deque_erase_front    container_erase_front
#define global deque_erase_back     container_erase_back
#define global deque_loc_swap_front container_loc_swap_front
#define global deque_loc_swap_back  container_loc_swap_back
#define global deque_rotate         container_rotate
#define global deque_rotate_back    container_rotate_back
#define global deque_reverse        container_reverse
#define global deque_clear          container_clear
#define global deque_chain          container_chain
#define global deque_copy           container_copy
#define global deque_swap           container_swap
#define global deque_iter_init      container_iter_init
#define global deque_iter_next      container_iter_next
#define global deque_size           container_size
#define global deque_length         deque_size
#define global deque_empty          container_empty
#define global deque_count          container_count
#define global deque_is_valid       container_is_valid
#define global deque_dbglog         container_dbglog

#define global queueNull           dequeNull
#define global queue_make          deque_make
#define global queue_new           deque_new
#define global queue_delete        deque_delete
#define global queue_getv          deque_getv
#define global queue_peekv         queue_getv
#define global queue_get           deque_get
#define global queue_peek          queue_get
#define global queue_clone         deque_clone
#define global queue_ref           deque_ref
#define global queue_get_front     deque_get_front
#define global queue_getv_front    deque_getv_front
#define global queue_pop_front     deque_pop_front
#define global queue_popv_front    deque_popv_front
#define global queue_popv          deque_popv_front
#define global queue_pop           deque_pop_front
#define global queue_vartype       container_vartype_front
#define global queue_vartype_front container_vartype_front
#define global queue_set           deque_set
#define global queue_setv          deque_setv
#define global queue_insert        deque_insert
#define global queue_insertv       deque_insertv
#define global queue_double_front  deque_double_front
#define global queue_double_back   deque_double_back
#define global queue_push_back     deque_push_back
#define global queue_pushv_back    deque_pushv_back
#define global queue_add           queue_push
#define global queue_push          deque_push_back
#define global queue_pushv         deque_pushv_back
#define global queue_erase         deque_erase_front
#define global queue_clear         deque_clear
#define global queue_chain         deque_chain
#define global queue_copy          deque_copy
#define global queue_swap          deque_swap
#define global queue_iter_init     deque_iter_init
#define global queue_iter_next     deque_iter_next
#define global queue_size          deque_size
#define global queue_length        queue_size
#define global queue_empty         deque_empty
#define global queue_count         deque_count
#define global queue_is_valid      deque_is_valid
#define global queue_dbglog        deque_dbglog

#define global ArrayInsert stdarray_insert_room
#define global ArrayRemove stdarray_erase
#define global ArrayMove stdarray_loc_move
#define global ArraySwap stdarray_swap
#define global ArrayRotate stdarray_rotate
#define global ArrayRotateBack stdarray_rotate_back
#define global ArrayReverse stdarray_reverse

#define global container_exchange container_swap
#define global list_exchange list_swap
#define global deque_exchange deque_swap
#define global stack_exchange stack_swap
#define global queue_exchange queue_swap
#define global tnode_exchange tnode_swap
#define global unor_exchange unor_swap
#define global pair_exchange pair_swap

#define global container_setSize container_resize
#define global list_setSize list_resize
#define global deque_setSize deque_resize
#define global stack_setSize stack_resize
#define global queue_setSize queue_resize

#define global container_iterInit container_iter_init
#define global list_iterInit list_iter_init
#define global deque_iterInit deque_iter_init
#define global stack_iterInit stack_iter_init
#define global queue_iterInit queue_iter_init
#define global tnode_iterInit tnode_iter_init
#define global unor_iterInit unor_iter_init
#define global pair_iterInit pair_iter_init

#define global container_iterNext container_iter_next
#define global list_iterNext list_iter_next
#define global deque_iterNext deque_iter_next
#define global stack_iterNext stack_iter_next
#define global queue_iterNext queue_iter_next
#define global tnode_iterNext tnode_iter_next
#define global unor_iterNext unor_iter_next
#define global pair_iterNext pair_iter_next

#define global container_move container_loc_move
#define global list_move list_loc_move
#define global deque_move deque_loc_move
#define global stack_move stack_loc_move
#define global queue_move queue_loc_move

#define global container_remove container_erase
#define global container_remove_front container_erase_front
#define global container_remove_back container_erase_back
#define global list_remove list_erase
#define global list_remove_front list_erase_front
#define global list_remove_back list_erase_back
#define global deque_remove deque_erase
#define global deque_remove_front deque_erase_front
#define global deque_remove_back deque_erase_back
#define global stack_remove stack_erase
#define global stack_remove_front stack_erase_front
#define global stack_remove_back stack_erase_back
#define global queue_remove queue_erase
#define global queue_remove_front queue_erase_front
#define global queue_remove_back queue_erase_back

#define global container_isValid container_is_valid
#define global list_isValid list_is_valid
#define global deque_isValid deque_is_valid
#define global queue_isValid queue_is_valid

#define global unor_count unor_size
#define global unor_exists unor_count_key

#define global pair_getLhs pair_get_lhs
#define global pair_getRhs pair_get_rhs
#define global pair_getBoth pair_get_both
#define global pair_getvLhs pair_getv_lhs
#define global pair_getvRhs pair_getv_rhs
#define global pair_getvBoth pair_getv_both
#define global pair_setLhs pair_set_lhs
#define global pair_setRhs pair_set_rhs
#define global pair_setBoth pair_set_both
#define global pair_setvLhs pair_setv_lhs
#define global pair_setvRhs pair_setv_rhs
#define global pair_setvBoth pair_setv_both
#define global pair_cloneLhs pair_clone_lhs
#define global pair_cloneRhs pair_clone_rhs
#define global pair_cloneBoth pair_clone_both
#define global pair_vartypeLhs pair_vartype_lhs
#define global pair_vartypeRhs pair_vartype_rhs
#define global pair_vartypeBoth pair_vartype_both

#define global new_container container_make
#define global new_list list_make
#define global new_deque deque_make
#define global new_stack stack_make
#define global new_queue queue_make
#define global new_tnode tnode_make
#define global new_unor unor_make
#define global new_pair pair_make

#endif
