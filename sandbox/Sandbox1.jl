using Dates
using LifeSimulator

include("../src/LifeSimulator.jl")

using MortalityTables


# define model 



λ = -log(0.999441703848)
α = -log(0.999733441115)*log(1.101077536030)
β = log(1.101077536030)
model = LifelibBasiclife(mortality = hazard(Makeham(λ, α, β),55))
model2 = LifelibBasiclife(mortality = TabularMortality())
# Select the model you want to use, with parameters you like.
# Read the documentation with `?LifelibBasiclife` (help mode) in the REPL.

test = TabularMortality()
model = LifelibBasiclife(inflation_rate = 0.03)
model = LifelibBasiclife(mortality = test)

model.mortality = makeham()
model.acquisition_cost

model.lapse
model.load_premium_rate


policies = [
    PolicySet(Policy(term = Year(20), age = Year(20), premium = 200_000), 100),
    PolicySet(Policy(term = Year(20), age = Year(45), premium = 600_000), 80),
    PolicySet(Policy(term = Year(10), age = Year(70), premium = 400_000), 50),
]

n= 100

simulate(model, policies, n) do events 
    cf = CashFlow(events, model)
    display(cf)
end ;

Makeham()

hazard(Makeham(c=λ, a=α, b=β),55)
test = TabularMortality()

test.rates


estimate_premiums(model, policies,n)