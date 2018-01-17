
class Bank

  constructor: (@id) ->
    @balance = 0

  deposit: (amount) ->
    @balance += amount
    @

  withdraw: (amount) ->
    @balance -= amount
    @

opened = (id) -> new Bank id
deposited = (amount, bank) -> bank.deposit amount
withdrew = (amount, bank) -> bank.withdraw amount

lfold = (events) -> _.reduce events, apply_event, @
apply_event = (result, event) -> event.apply result

















describe 'Bank', ->

  sut = [
    -> opened 42
    -> deposited 100, @
    -> deposited 50, @
    -> withdrew 75, @
  ]

  it 'works', ->
    lfold sut
    .balance.should.eql 75


















