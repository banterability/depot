beforeEach ->
  @store = new Depot

describe "Events", ->
  describe "Bubbling", ->
    before ->
      @level3Spy = bond().return true
      @level2Spy = bond().return true
      @level1Spy = bond().return true
      @genericSpy = bond().return true

      @store.vent.on 'a:b:c', @level3Spy
      @store.vent.on 'a:b', @level2Spy
      @store.vent.on 'a', @level1Spy
      @store.vent.on '*', @genericSpy

      @store.vent.emit 'a:b:c', {status: 'ok'}, 'third arg'

    it "calls the third-level spy", ->
      @level3Spy.called.should.equal 1
      console.log @level3Spy.calledArgs[0]

    it "calls the second-level spy", ->
      @level2Spy.called.should.equal 1
      console.log @level2Spy.calledArgs[0]

    it "calls the first-level spy", ->
      @level1Spy.called.should.equal 1
      console.log @level1Spy.calledArgs[0]

    it "calls the generic spy", ->
      @genericSpy.called.should.equal 1
      console.log @genericSpy.calledArgs[0]
