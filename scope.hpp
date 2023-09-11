#ifndef KAUTIL_MEMORY_SCOPE_SCOPE_HPP
#define KAUTIL_MEMORY_SCOPE_SCOPE_HPP

namespace kautil {

template<typename X>
struct scope{
    explicit scope(X *x) :m(x){}
    ~scope(){ m->~X(); }
    X * operator &(){return m;}
private:
    X * m;
};

} //namespace kautil {



#endif