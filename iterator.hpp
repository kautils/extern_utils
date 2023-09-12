#ifndef KAUTIL_EXTERN_UTILS_ITERATOR_HPP
#define KAUTIL_EXTERN_UTILS_ITERATOR_HPP

template<typename X>
struct iterator{
    explicit iterator(X * x ) :m(x){}
    iterator & operator++(){ ++(*m);return *this; }
    X & operator*(){ return *m; }
    bool operator!=(const iterator & l){ return *m != *l.m; }
    iterator begin(){ return iterator{&m->begin()}; }
    iterator end(){ return iterator{&m->end()}; }
private:
    X * m;
};


#endif