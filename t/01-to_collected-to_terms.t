use Math::Symbolic qw(:all);
use Math::Symbolic::Custom::Collect;

use Test::More;

my @tests = (
    # constant expressions
    '-0/1',
    '0/1',
    '(0+(8/13))+(5/13)',
    '-10/5',
    '10/5',
    '-1+(1/2)',
    '-1-(1/2)',
    '1+(1/2)',
    '1-(1/2)',
    '11/2',
    '(11/2)*2',
    '-11/-22',
    '-11/5',
    '11/5',
    '(1/2)-1',
    '-(1/2)-1',
    '(1/2)+(1/2)',
    '(1/2)-(1/2)',
    '-(1/2)+(-1/2)',
    '-(1/2)-(1/-2)',
    '(1/2)+(1/4)+(1/4)',
    '(1/2)-(3/4)',
    '-(1/2)-(3/-4)',
    '-1*2*3*4*5*6*7*8*9',
    '-1+2*3+4*5+6*7+8*9',
    '-1+2+3+4-5+6+7+8+9',
    '-1+2-3+4-5+6-7+8-9',
    '-1-2-3-4-5-6-7-8-9',
    '-1/2/-3/4/-5/6/-7/-8/9',
    '1*2*3*4*5*6*7*8*9',
    '1+2*3+4*5+6*7+8*9',
    '1+2+3+4+5+6+7+8+9',
    '1+2-3+4-5+6-7+8-9',
    '1-2-3-4-5-6-7-8-9',
    '1/2/3/4/5/6/7/8/9',
    '(1/4)/(1/2)',
    '-(1/4)/(1/-2)',
    '(1/4)*(1*2*3)',
    '-(1/4)*(1*2*3)',
    '-(1/4)*(1*-2*3)',
    '(1/4)*(1/3)*(1/2)*5',
    '-(1/4)*(1/3)*(1/2)*5',
    '-1/-7',
    '-1/7',
    '1/-7',
    '1/7',
    '2001/3000',
    '2/1',
    '2*(10/2)',
    '-2*(1/-4)',
    '2*(1/4)',
    '(-2/-3)-(1/6)',
    '(-2/3)-(1/6)',
    '(2/-3)-(1/6)',
    '(2/3)-(-1/-6)',
    '(2/3)-(-1/6)',
    '(2/3)-(1/-6)',
    '(2/3)-(1/6)',
    '(2/4)+(1/4)',
    '(2/4)-(2/8)',
    '(2*4+3^3)-(9+8+7+6+5+4+3+2+1)',
    '24/36',
    '(2*4)-(6*3)',
    '(2*4)-(6-3)',
    '(2*4)-(9+8+7+6+5+4+3+2+1)',
    '2740/8220',
    '3*((10+12)/6)',
    '(3/10)/(18/25)',
    '-3*(1/4)',
    '3*(1/4)',
    '(3*3)/(3-1)',
    '36/30',
    '(4/5)*(2/3)',
    '45/75',
    '-5/1',
    '5/1',
    '-5/10',
    '5/-10',
    '-7/4',
    '7/4',
    '(8+3^3)-(9+8+7+6+5+4+3+2+1)',
    '8-(6*3)',
    '8-(6-3)',
    '8-(9+8+7+6+5+4+3+2+1)',

    # variable expressions
    '1/(1-(1/x))',
    '(1/14)*(x+x+y)',
    '-(1/14)*(x+x+y)',
    '((1/2)*x^2 + 2*x + (1/4))*2',
    '-((1/2)*x^2 + 2*x - (1/4))*2',
    '((1/2)*x^2 + 2*x + (1/4))*x^2',
    '-((1/2)*x^2 + 2*x + (1/4))*x^2',
    '((1/2)*x^2 + 2*x + (1/4))*(x+z+y)',
    '-((1/2)*x^2 - 2*x + (1/4))*(x+z+y)',
    '(1+2+x)*(sin(y)+z)',
    '-(1+2+x)*(sin(y)-z)',
    '(1+2+x)*(y+z)',
    '-(1-2+x)*(y-z)',
    '(1+2+x)*((y+z)*(a+b+c))',
    '(1+2+x)*((y+z)*(a-b-c))',
    '-(1+2+x)*((y+z)*(a+b+c))',
    '-(1+2+x)*((y+z)*(a-b-c))',
    '(-12*y+36)/-8',
    '((1/(3*a))-(1/(3*b)))/((a/b)-(b/a))',
    '((1/4)+(1/2))*3*x',
    '-(1/4)*(1/3)*(1/2)*5',
    '(1/4)*2+(x/2)',
    '((((1/5)*(x+(z*y)))/2)*(((1/5)*(x+(z*y)))/3))/4',
    '-((((1/5)*(x+(z*y)))/2)*(((1/5)*(x+(z*y)))/3))/4',
    '-((((1/5)*(x-(z*y)))/2)*(((1/-5)*(x+(z*y)))/3))/4',
    '(1/sqrt(x))*(1/sqrt(x))',
    '-1*(x+1)*(x+1)+1',
    '(1/(x+1))+(x/(4-x))-(1/(x-2))',
    '(21*w+9)/15',
    '-2/(-2*x)',
    '-2/-x',
    '2/-x',
    '(3*(r^2))/(r^3)',
    '4*x*(1/4)',
    '(5*x)/(1-(1/x))',
    '(5/(x+1))-((x-2)/(x+1))',
    '-(5/(x+1))-((x-2)/(x-1))',
    '5*x^3',
    '5*x^(3+z)',
    '5*x^(3+z)*5',
    '(5+y)*x^2',
    '(5+y)*x^2*(5+y)',
    '(5+y)*x^(2-k)',
    '(5+y)*x^(2-k)*(5+y)',
    '(5*z-30)/-5',
    '6*x^3*5',
    '(6*x+4)/2',
    '(a-a^2)/(3*a^3-3*a)',
    '(a*(b+c))/((b+c)*a)',
    '-cos(10/5)',
    'cos(10/5)',
    '-cos(11/5)',
    'cos(11/5)',
    '-cos((1+2-x)*(sin(y)+z))',
    'cos((1+2+x)*(sin(y)+z))',
    '-cos((1-2+x)*(y+z))',
    'cos((1+2+x)*(y+z))',
    '-cos((1+2+x)*((y+z)*(a-b-c)))',
    '-cos((1+2+x)*((y-z)*(a+b+c)))',
    'cos((1+2+x)*((y+z)*(a+b+c)))',
    'cos((1+2+x)*((y+z)*(a-b-c)))',
    '-cos(-1/-7)',
    '-cos(-1/7)',
    '-cos(1/-7)',
    'cos(-1/-7)',
    'cos(-1/7)',
    'cos(1/-7)',
    '-cos(5/1)',
    'cos(5/1)',
    '-cos(7/4)',
    'cos(7/4)',
    '-cos(x^2+y^2)',
    'cos(x^2+y^2)',
    '-cos(((x+y)^2)/7)',
    'cos(((x+y)^2)/7)',
    '(sinh(sin(x)+cos(y))+cosh(sin(x)+cos(y)))*(sinh(x)-cosh(y))',
    '-(sinh(sin(x)-cos(y))+cosh(sin(x)-cos(y)))*(sinh(x)-cosh(y))',
    '(sinh(x)+cosh(y))*(sinh(x)+cosh(y))',
    '(sinh(x)+cosh(y))*(sinh(x)-cosh(y))',
    '-(sinh(x)+cosh(y))*(sinh(x)-cosh(y))',
    '-(sinh(x)-cosh(y))*(sinh(x)+cosh(y))',
    'sin((x+4)*(x+1))*sin((x+1)*(x+4))',
    '(sin(x)*b + sin(x)*c)/(sin(x)*a + sin(x)*d)',
    '-sin(x)*(x+y+z)',
    'sin(x)*(x+y+z)',
    'sqrt(x)*sqrt(x)',
    'sqrt(x)*sqrt(x)*sqrt(x)',
    'sqrt(x)*sqrt(x)*sqrt(x)*sqrt(x)',
    'x^(-2)',
    '((x*(2/14))+(x*y))*y',
    '-((x*(2/14))+(x*y))*y',
    'x^2+4*x+4+((13*x+7)/(x^2-x-2))',
    'x^2*(5+y)',
    'x^(2-k)*(5+y)',
    'x^2 / x',
    '-x^2-y^2',
    'x^2+y^2',
    '(x^2+y^2)/(k^2+l^2)',
    '-(x^2+y^2)/(k^2+l^2)',
    'x^3*5',
    'x^-3 * x^2',
    'x^(3+z)*5',
    '-x^(4*(x+y))',
    'x^(4*(x+y))',
    '(x*a-x*b)/(x*a+x*b)',
    '-(x*a-x*b)/(x*a-x*b)',
    '(x^m)^(n)',
    'x/x',
    '((x+y)^2)/7',
    '-((x+y)^2)/-7',
    '(((x+y)/2)*((x+y)/3))/4',
    '-(((x+y)/2)*((x+y)/3))/4',
    '-(((x+y)/2)*((x-y)/3))/-4',
    '(((x+y)/2)*((x+y)/3))/(x+y)',
    '-(((x+y)/2)*((x+y)/3))/(x+y)',
    '((x+y)^m) * ((x+y)^n)',
    '(x+y)*(((x+y)/14) + ((x+y)/12))',
    '-(x+y)*(((x+y)/14) + ((x+y)/12))',
    '-(x+y)*(((x-y)/14) + ((x+y)/12))',
    '(x+y+z)/2',
    '(x+y+z)*x',
    '-(x-y-z)*x',
    '(x+y+z)*x^2',
    '-(x+y-z)*x^2',
    '((x+y+z)*x^2)/5',
    '-((x-y+z)*x^2)/5',
    '(y+x)*(x+2*x)*(1+(y*x))',
    '-(y+x)*(x+2*x)*(1+(y*x))',
    '((y/x)*z)+((y/x)*y)',
    '-((y/x)*z)+((y/x)*y)',
);

TEST_LOOP: foreach my $test (@tests) {
    my $f = parse_from_string($test);
    # can the parser parse the test string?
    ok( defined($f), "parsing test string [$test]" );
    if (!defined $f) {
        next TEST_LOOP;
    }  

    # test to_collected()
    my $f2 = $f->to_collected();
    ok( defined($f2), "to_collected() returns defined [$f2] ($test)" );
    if (!defined $f2) {
        next TEST_LOOP;
    }   
    
    # the new Math::Symbolic tree should be numerically equivalent to the original tree
    ok($f->test_num_equiv($f2, upper => 4, lower => -4, tests => 10, epsilon => 1e-5), "output expression from to_collected() is numerically equivalent to original [$test |vs| $f2]");  

    # test to_terms()
    my @terms = $f->to_terms();
    ok( scalar(@terms) > 0, "to_terms() returns a list with entries [" . join("][", @terms) . "] ($test)" );
    if ( scalar(@terms) == 0 ) {
        next TEST_LOOP;
    }

    # adding all the terms together should give an expression numerically equivalent to the original
    my $p = shift @terms;
    while (defined(my $x = shift @terms)) {
        $p += $x;
    }

    ok($f->test_num_equiv($p, upper => 4, lower => -4, tests => 10, epsilon => 1e-5), "summed output expression from to_terms() is numerically equivalent to original [$test |vs| $p]");  
}

done_testing( 5*scalar(@tests) );


