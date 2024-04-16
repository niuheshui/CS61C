#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    node *first = head, *second = head;
    
    while (second && second->next) {
        first = first->next;
        second = second->next->next;
        if (second == first) return 1;
    }

    /* your code here */
    return 0;
}
