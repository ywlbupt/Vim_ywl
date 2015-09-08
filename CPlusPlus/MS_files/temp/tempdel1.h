#include <iostream>
#include <string>
#include <vector>
#include <map>
using namespace std;
class ywl
{
	private:
		static auto_ptr<ywl> m_auto_ptr;
		static ywl * m_ins;
	public:
		static ywl * Ins();
	protected:
		ywl();
		ywl(const ywl&);
		virtual ~ywl();
		friend class auto_ptr<ywl>; 
};

